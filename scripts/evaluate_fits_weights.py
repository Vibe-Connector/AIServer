"""
FITS_* Relationship Weight Evaluator
Uses GPT-4o-mini to evaluate fitness scores between items and context nodes,
then creates FITS_MOOD/TIME/WEATHER/PLACE/COMPANION relationships in Neo4j.

Only processes items that don't yet have FITS_* relationships.
Has resume capability via progress file.

Usage:
    cd AIServer
    source .venv/bin/activate
    python scripts/evaluate_fits_weights.py
"""

import json
import logging
import time
import sys
from pathlib import Path

# Suppress Neo4j driver warnings
logging.getLogger("neo4j").setLevel(logging.ERROR)

from neo4j import GraphDatabase
from openai import OpenAI


def log(msg):
    print(msg, flush=True)

# ── Configuration ────────────────────────────────────────────────────────────
NEO4J_URI = "bolt://localhost:7687"
NEO4J_USER = "neo4j"
NEO4J_PASS = "vibeconnector2024"

OPENAI_API_KEY = os.getenv(
    "OPENAI_API_KEY",
    "",
)
AWS_ACCESS_KEY = os.getenv("AWS_ACCESS_KEY", "")
AWS_SECRET_KEY = os.getenv("AWS_SECRET_KEY", "")
AWS_S3_BUCKET = os.getenv("AWS_S3_BUCKET", "")
AWS_REGION = os.getenv("AWS_REGION", "")

WEIGHT_THRESHOLD = 0.3
PROGRESS_FILE = Path(__file__).parent / "fits_eval_progress.json"

LABEL_TO_CATEGORY = {
    "Movie": "movie", "Music": "music",
    "Coffee": "coffee", "Lighting": "lighting",
}

# ── Cypher Queries ───────────────────────────────────────────────────────────

GET_ALL_OPTIONS = """
CALL {
    MATCH (m:Mood) RETURN collect({keyword_id: m.keyword_id, keyword_value: m.keyword_value, category: m.category}) AS moods
}
CALL {
    MATCH (t:Time) RETURN collect({time_id: t.time_id, time_key: t.time_key}) AS times
}
CALL {
    MATCH (w:Weather) RETURN collect({weather_id: w.weather_id, weather_key: w.weather_key}) AS weathers
}
CALL {
    MATCH (p:Place) RETURN collect({place_id: p.place_id, place_key: p.place_key}) AS places
}
CALL {
    MATCH (c:Companion) RETURN collect({companion_id: c.companion_id, companion_key: c.companion_key}) AS companions
}
RETURN moods, times, weathers, places, companions
"""

GET_ITEMS_WITHOUT_FITS = """
MATCH (item)
WHERE (item:Movie OR item:Music OR item:Coffee OR item:Lighting)
  AND NOT (item)-[:FITS_MOOD]->()
  AND NOT (item)-[:FITS_TIME]->()
RETURN item, labels(item) AS item_labels
ORDER BY item.item_id
"""

GET_ALL_ITEMS = """
MATCH (item)
WHERE item:Movie OR item:Music OR item:Coffee OR item:Lighting
RETURN item, labels(item) AS item_labels
ORDER BY item.item_id
"""

CREATE_FITS = {
    "moods": (
        "MATCH (item {item_id: $item_id}) "
        "MATCH (m:Mood {keyword_id: $option_id}) "
        "MERGE (item)-[r:FITS_MOOD]->(m) "
        "SET r.weight = $weight"
    ),
    "times": (
        "MATCH (item {item_id: $item_id}) "
        "MATCH (t:Time {time_id: $option_id}) "
        "MERGE (item)-[r:FITS_TIME]->(t) "
        "SET r.weight = $weight"
    ),
    "weathers": (
        "MATCH (item {item_id: $item_id}) "
        "MATCH (w:Weather {weather_id: $option_id}) "
        "MERGE (item)-[r:FITS_WEATHER]->(w) "
        "SET r.weight = $weight"
    ),
    "places": (
        "MATCH (item {item_id: $item_id}) "
        "MATCH (p:Place {place_id: $option_id}) "
        "MERGE (item)-[r:FITS_PLACE]->(p) "
        "SET r.weight = $weight"
    ),
    "companions": (
        "MATCH (item {item_id: $item_id}) "
        "MATCH (c:Companion {companion_id: $option_id}) "
        "MERGE (item)-[r:FITS_COMPANION]->(c) "
        "SET r.weight = $weight"
    ),
}


def build_item_description(item: dict, labels: list[str]) -> str:
    """Build a description string for LLM evaluation."""
    category = "unknown"
    for label in labels:
        if label in LABEL_TO_CATEGORY:
            category = LABEL_TO_CATEGORY[label]
            break

    parts = [f"[{category}] {item.get('name', item.get('item_key', ''))}"]

    if category == "movie":
        if item.get("genres"):
            parts.append(f"장르: {', '.join(item['genres'])}")
        if item.get("overview"):
            parts.append(f"개요: {str(item['overview'])[:150]}")
        if item.get("keywords"):
            parts.append(f"키워드: {', '.join(item['keywords'])}")
    elif category == "music":
        if item.get("artists"):
            parts.append(f"아티스트: {', '.join(item['artists'])}")
        if item.get("genres"):
            genres = item['genres'][:5]  # Limit genres for music (can have many)
            parts.append(f"장르: {', '.join(genres)}")
        if item.get("album_name"):
            parts.append(f"앨범: {item['album_name']}")
    elif category == "coffee":
        if item.get("capsule_name"):
            parts.append(f"캡슐: {item['capsule_name']}")
        if item.get("roast_level"):
            parts.append(f"로스팅: {item['roast_level']}")
        if item.get("intensity"):
            parts.append(f"강도: {item['intensity']}")
        if item.get("flavor_notes"):
            parts.append(f"풍미: {str(item['flavor_notes'])[:100]}")
        if item.get("aroma_profile"):
            parts.append(f"아로마: {', '.join(item['aroma_profile'])}")
    elif category == "lighting":
        if item.get("color_temp_name"):
            parts.append(f"색온도: {item['color_temp_name']}")
        if item.get("color_temp_kelvin"):
            parts.append(f"{item['color_temp_kelvin']}K")
        if item.get("brightness_percent") is not None:
            parts.append(f"밝기: {item['brightness_percent']}%")
        if item.get("lighting_type"):
            parts.append(f"타입: {item['lighting_type']}")
        if item.get("space_context"):
            parts.append(f"공간: {item['space_context']}")
        if item.get("time_context"):
            parts.append(f"시간대: {item['time_context']}")

    return " | ".join(parts)


def load_progress() -> set:
    if PROGRESS_FILE.exists():
        data = json.loads(PROGRESS_FILE.read_text())
        return set(data.get("completed", []))
    return set()


def save_progress(completed: set):
    PROGRESS_FILE.write_text(json.dumps({"completed": sorted(completed)}))


def evaluate_item(client: OpenAI, description: str, options: dict) -> dict:
    """Call GPT to evaluate fitness scores for a single item."""
    system = (
        "당신은 아이템과 분위기의 적합도를 평가하는 전문가입니다.\n"
        "주어진 아이템 설명을 보고, 각 분위기/시간/날씨/장소/동반자 옵션과의 적합도를 "
        "0.0~1.0 사이 점수로 평가하세요.\n"
        "0.3 미만은 관계를 만들지 않습니다. 적합한 항목만 포함하세요 (0.3 미만은 생략).\n"
        "0.3~0.5: 약간 어울림, 0.5~0.7: 어울림, 0.7~0.9: 잘 어울림, 0.9~1.0: 완벽히 어울림\n"
        "반드시 JSON 형식으로만 응답하세요. 설명 없이 JSON만 출력하세요."
    )

    user = (
        f"아이템: {description}\n\n"
        f"Moods: {json.dumps(options['moods'], ensure_ascii=False)}\n"
        f"Times: {json.dumps(options['times'], ensure_ascii=False)}\n"
        f"Weathers: {json.dumps(options['weathers'], ensure_ascii=False)}\n"
        f"Places: {json.dumps(options['places'], ensure_ascii=False)}\n"
        f"Companions: {json.dumps(options['companions'], ensure_ascii=False)}\n\n"
        "각 옵션에 대해 적합도 점수를 매겨주세요. 0.3 미만은 생략하세요. 형식:\n"
        '{"moods": {"1": 0.7, "3": 0.5}, "times": {"11": 0.8}, '
        '"weathers": {"3": 0.6}, "places": {"1": 0.9}, '
        '"companions": {"1": 0.7}}'
    )

    response = client.chat.completions.create(
        model=OPENAI_MODEL,
        messages=[
            {"role": "system", "content": system},
            {"role": "user", "content": user},
        ],
        temperature=0.3,
        max_tokens=1500,
    )

    content = response.choices[0].message.content.strip()
    if "```json" in content:
        content = content.split("```json")[1].split("```")[0].strip()
    elif "```" in content:
        content = content.split("```")[1].split("```")[0].strip()

    return json.loads(content)


def create_fits_relationships(neo_session, item_id: int, scores: dict) -> int:
    """Create FITS_* relationships in Neo4j based on scores."""
    rel_count = 0
    for context_type, query_template in CREATE_FITS.items():
        for option_id_str, weight in scores.get(context_type, {}).items():
            w = float(weight)
            if w >= WEIGHT_THRESHOLD:
                neo_session.run(
                    query_template,
                    item_id=item_id,
                    option_id=int(option_id_str),
                    weight=w,
                )
                rel_count += 1
    return rel_count


def main():
    reeval_all = "--all" in sys.argv

    log("=" * 60)
    log("FITS_* Weight Evaluator")
    log("=" * 60)

    # Connect
    neo_driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASS))
    openai_client = OpenAI(api_key=OPENAI_API_KEY)

    with neo_driver.session() as session:
        # 1. Get all context options
        log("\n[1] 컨텍스트 옵션 로드 중...")
        result = session.run(GET_ALL_OPTIONS)
        record = result.single()
        options = {
            "moods": [dict(m) for m in record["moods"]],
            "times": [dict(t) for t in record["times"]],
            "weathers": [dict(w) for w in record["weathers"]],
            "places": [dict(p) for p in record["places"]],
            "companions": [dict(c) for c in record["companions"]],
        }
        log(f"  Moods: {len(options['moods'])}, Times: {len(options['times'])}, "
              f"Weathers: {len(options['weathers'])}, Places: {len(options['places'])}, "
              f"Companions: {len(options['companions'])}")

        # 2. Get items to evaluate
        log("\n[2] 평가 대상 아이템 조회 중...")
        if reeval_all:
            result = session.run(GET_ALL_ITEMS)
            log("  (--all 모드: 전체 아이템 재평가)")
        else:
            result = session.run(GET_ITEMS_WITHOUT_FITS)

        items = []
        for record in result:
            item = dict(record["item"])
            labels = list(record["item_labels"])
            items.append((item, labels))

        # Filter by progress
        completed = load_progress()
        pending = [(item, labels) for item, labels in items
                   if item["item_id"] not in completed]

        log(f"  전체 대상: {len(items)}개, 이미 완료: {len(completed)}개, "
              f"남은 작업: {len(pending)}개")

        if not pending:
            log("\n모든 아이템이 이미 평가되었습니다.")
            neo_driver.close()
            return

        # 3. Evaluate and create relationships
        log(f"\n[3] GPT 평가 및 FITS_* 관계 생성 시작...")
        total_rels = 0
        errors = 0

        for i, (item, labels) in enumerate(pending):
            item_id = item["item_id"]
            desc = build_item_description(item, labels)
            category = "unknown"
            for label in labels:
                if label in LABEL_TO_CATEGORY:
                    category = LABEL_TO_CATEGORY[label]
                    break

            try:
                scores = evaluate_item(openai_client, desc, options)
                rels = create_fits_relationships(session, item_id, scores)
                total_rels += rels

                completed.add(item_id)
                if (i + 1) % 10 == 0:
                    save_progress(completed)

                log(f"  [{i+1}/{len(pending)}] {category:8} id={item_id:>10} "
                      f"'{item.get('name', '')[:25]:25}' → {rels} rels")

            except Exception as e:
                errors += 1
                log(f"  [{i+1}/{len(pending)}] ERROR id={item_id}: {e}")
                # Retry once after short delay
                time.sleep(2)
                try:
                    scores = evaluate_item(openai_client, desc, options)
                    rels = create_fits_relationships(session, item_id, scores)
                    total_rels += rels
                    completed.add(item_id)
                    errors -= 1
                    log(f"    → 재시도 성공: {rels} rels")
                except Exception as e2:
                    log(f"    → 재시도 실패: {e2}")

            # Rate limit: ~500 RPM for gpt-4o-mini → safe at 0.15s
            if (i + 1) % 50 == 0:
                save_progress(completed)
                time.sleep(1)

        save_progress(completed)

    neo_driver.close()

    log(f"\n{'=' * 60}")
    log(f"완료!")
    log(f"  처리된 아이템: {len(pending)}개")
    log(f"  생성된 관계: {total_rels}개")
    log(f"  오류: {errors}개")
    log(f"{'=' * 60}")


if __name__ == "__main__":
    main()
