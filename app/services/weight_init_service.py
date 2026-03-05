"""
FITS_* 관계 가중치 초기화 서비스.

LLM을 사용하여 각 아이템과 옵션(mood/time/weather/place/companion)간의
적합도 점수를 평가하고, Neo4j 그래프에 FITS_* 관계로 저장합니다.
"""

import asyncio
import json

import structlog

from app.config import settings
from app.graph import queries
from app.graph.repository import execute_read, execute_write
from app.services.llm_service import get_llm

logger = structlog.get_logger()

# 모든 옵션 데이터를 그래프에서 조회하는 쿼리
_GET_ALL_OPTIONS = """
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

_GET_ALL_ITEMS = """
MATCH (item)
WHERE item:Movie OR item:Music OR item:Coffee OR item:Lighting
RETURN item, labels(item) AS item_labels
"""

_LABEL_TO_CATEGORY = {"Movie": "movie", "Music": "music", "Coffee": "coffee", "Lighting": "lighting"}


def _build_item_description(item: dict, labels: list[str]) -> str:
    """아이템 노드 속성으로 LLM에 전달할 설명 문자열 생성"""
    category = "unknown"
    for label in labels:
        if label in _LABEL_TO_CATEGORY:
            category = _LABEL_TO_CATEGORY[label]
            break

    parts = [f"[{category}] {item.get('name', item.get('item_key', ''))}"]

    if category == "movie":
        if item.get("genres"):
            parts.append(f"장르: {', '.join(item['genres'])}")
        if item.get("overview"):
            parts.append(f"개요: {item['overview'][:150]}")
        if item.get("keywords"):
            parts.append(f"키워드: {', '.join(item['keywords'])}")
    elif category == "music":
        if item.get("artists"):
            parts.append(f"아티스트: {', '.join(item['artists'])}")
        if item.get("genres"):
            parts.append(f"장르: {', '.join(item['genres'])}")
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
            parts.append(f"풍미: {item['flavor_notes']}")
        if item.get("aroma_profile"):
            parts.append(f"아로마: {', '.join(item['aroma_profile'])}")
    elif category == "lighting":
        if item.get("color_temp_name"):
            parts.append(f"색온도: {item['color_temp_name']}")
        if item.get("color_temp_kelvin"):
            parts.append(f"{item['color_temp_kelvin']}K")
        if item.get("brightness_percent"):
            parts.append(f"밝기: {item['brightness_percent']}%")
        if item.get("lighting_type"):
            parts.append(f"타입: {item['lighting_type']}")
        if item.get("space_context"):
            parts.append(f"공간: {item['space_context']}")
        if item.get("time_context"):
            parts.append(f"시간대: {item['time_context']}")

    return " | ".join(parts)


async def evaluate_and_create_fits(batch_size: int = 5) -> dict:
    """모든 아이템에 대해 LLM 적합도 평가 후 FITS_* 관계 생성"""
    # 1. 옵션 데이터 조회
    option_records = await execute_read(_GET_ALL_OPTIONS, {})
    if not option_records:
        return {"error": "옵션 데이터가 없습니다. 먼저 옵션을 ingest하세요."}

    record = option_records[0]
    moods = list(record["moods"])
    times = list(record["times"])
    weathers = list(record["weathers"])
    places = list(record["places"])
    companions = list(record["companions"])

    # 2. 아이템 데이터 조회
    item_records = await execute_read(_GET_ALL_ITEMS, {})
    if not item_records:
        return {"error": "아이템 데이터가 없습니다. 먼저 아이템을 ingest하세요."}

    logger.info("weight_init_start", items=len(item_records), options={
        "moods": len(moods), "times": len(times), "weathers": len(weathers),
        "places": len(places), "companions": len(companions),
    })

    total_relations = 0
    processed_items = 0

    # 3. 배치 처리
    for i in range(0, len(item_records), batch_size):
        batch = item_records[i : i + batch_size]
        tasks = [
            _evaluate_single_item(
                dict(rec["item"]), list(rec["item_labels"]),
                moods, times, weathers, places, companions,
            )
            for rec in batch
        ]
        results = await asyncio.gather(*tasks, return_exceptions=True)

        for result in results:
            if isinstance(result, Exception):
                logger.error("weight_eval_error", error=str(result))
                continue
            total_relations += result

        processed_items += len(batch)
        logger.info("weight_init_progress", processed=processed_items, total=len(item_records))

    logger.info("weight_init_done", total_relations=total_relations)
    return {
        "items_processed": processed_items,
        "relationships_created": total_relations,
    }


async def _evaluate_single_item(
    item: dict,
    labels: list[str],
    moods: list[dict],
    times: list[dict],
    weathers: list[dict],
    places: list[dict],
    companions: list[dict],
) -> int:
    """단일 아이템에 대해 LLM 평가 후 FITS_* 관계 생성"""
    llm = get_llm()
    item_id = item["item_id"]
    description = _build_item_description(item, labels)

    system = (
        "당신은 아이템과 분위기의 적합도를 평가하는 전문가입니다.\n"
        "주어진 아이템 설명을 보고, 각 분위기/시간/날씨/장소/동반자 옵션과의 적합도를 "
        "0.0~1.0 사이 점수로 평가하세요.\n"
        "0.3 미만은 관계를 만들지 않습니다. 0.3~0.6은 '보통', 0.6 이상은 '적합'입니다.\n"
        "적합한 항목만 포함하세요 (0.3 미만은 생략).\n"
        "반드시 JSON 형식으로만 응답하세요."
    )

    user = (
        f"아이템: {description}\n\n"
        f"Moods: {json.dumps(moods, ensure_ascii=False)}\n"
        f"Times: {json.dumps(times, ensure_ascii=False)}\n"
        f"Weathers: {json.dumps(weathers, ensure_ascii=False)}\n"
        f"Places: {json.dumps(places, ensure_ascii=False)}\n"
        f"Companions: {json.dumps(companions, ensure_ascii=False)}\n\n"
        "각 옵션에 대해 적합도 점수를 매겨주세요. 0.3 미만은 생략하세요. 형식:\n"
        '{"moods": {"1": 0.7, "3": 0.5}, "times": {"11": 0.8}, '
        '"weathers": {"3": 0.6}, "places": {"1": 0.9}, '
        '"companions": {"1": 0.7}}'
    )

    from langchain_core.messages import HumanMessage, SystemMessage
    response = await llm.ainvoke([
        SystemMessage(content=system),
        HumanMessage(content=user),
    ])

    content = response.content.strip()
    if "```json" in content:
        content = content.split("```json")[1].split("```")[0].strip()
    elif "```" in content:
        content = content.split("```")[1].split("```")[0].strip()

    scores = json.loads(content)
    threshold = settings.relationship_weight_threshold
    rel_count = 0

    # FITS_MOOD
    for kid_str, weight in scores.get("moods", {}).items():
        if float(weight) >= threshold:
            await execute_write(queries.CREATE_FITS_MOOD, {
                "item_id": item_id, "keyword_id": int(kid_str), "weight": float(weight),
            })
            rel_count += 1

    # FITS_TIME
    for tid_str, weight in scores.get("times", {}).items():
        if float(weight) >= threshold:
            await execute_write(queries.CREATE_FITS_TIME, {
                "item_id": item_id, "time_id": int(tid_str), "weight": float(weight),
            })
            rel_count += 1

    # FITS_WEATHER
    for wid_str, weight in scores.get("weathers", {}).items():
        if float(weight) >= threshold:
            await execute_write(queries.CREATE_FITS_WEATHER, {
                "item_id": item_id, "weather_id": int(wid_str), "weight": float(weight),
            })
            rel_count += 1

    # FITS_PLACE
    for pid_str, weight in scores.get("places", {}).items():
        if float(weight) >= threshold:
            await execute_write(queries.CREATE_FITS_PLACE, {
                "item_id": item_id, "place_id": int(pid_str), "weight": float(weight),
            })
            rel_count += 1

    # FITS_COMPANION
    for cid_str, weight in scores.get("companions", {}).items():
        if float(weight) >= threshold:
            await execute_write(queries.CREATE_FITS_COMPANION, {
                "item_id": item_id, "companion_id": int(cid_str), "weight": float(weight),
            })
            rel_count += 1

    logger.info("item_fits_created", item_id=item_id, name=item.get("name", ""), relations=rel_count)
    return rel_count
