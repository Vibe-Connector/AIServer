import structlog

from app.config import settings
from app.graph import queries
from app.graph.repository import execute_read

logger = structlog.get_logger()


async def retrieve_by_vibe_context(
    mood_keyword_ids: list[int],
    time_id: int,
    weather_id: int,
    place_id: int,
    companion_id: int,
    limit: int = 20,
) -> list[dict]:
    """직접 컨텍스트 매칭으로 후보 아이템 검색"""
    records = await execute_read(
        queries.FIND_ITEMS_BY_VIBE_CONTEXT,
        {
            "mood_keyword_ids": mood_keyword_ids,
            "time_id": time_id,
            "weather_id": weather_id,
            "place_id": place_id,
            "companion_id": companion_id,
            "threshold": settings.relationship_weight_threshold,
            "limit": limit,
        },
    )

    items = []
    for record in records:
        node = record["item"]
        labels = record["item_labels"]
        category = _label_to_category(labels)
        items.append({
            "item_id": node["item_id"],
            "item_key": node.get("item_key", ""),
            "name": node.get("name", ""),
            "category": category,
            "score": record["total_score"],
            "properties": dict(node),
            "image_url": node.get("image_url", ""),
        })

    logger.info("graph_retrieval_done", items_found=len(items))
    return items


async def retrieve_by_similar_patterns(
    mood_keywords: list[str],
    limit: int = 10,
) -> list[dict]:
    """유사한 VibePattern에서 추천된 아이템 검색"""
    records = await execute_read(
        queries.FIND_SIMILAR_PATTERNS,
        {"mood_keywords": mood_keywords, "limit": limit},
    )

    items = []
    for record in records:
        node = record["item"]
        labels = record["item_labels"]
        category = _label_to_category(labels)
        items.append({
            "item_id": node["item_id"],
            "item_key": node.get("item_key", ""),
            "name": node.get("name", ""),
            "category": category,
            "score": record["score"],
            "properties": dict(node),
            "image_url": node.get("image_url", ""),
        })

    return items


async def retrieve_all(
    mood_keyword_ids: list[int],
    mood_keywords: list[str],
    time_id: int,
    weather_id: int,
    place_id: int,
    companion_id: int,
    max_per_category: int = 5,
) -> dict[str, list[dict]]:
    """모든 전략을 결합하여 카테고리별 후보 아이템 반환"""
    # 직접 매칭
    direct_items = await retrieve_by_vibe_context(
        mood_keyword_ids=mood_keyword_ids,
        time_id=time_id,
        weather_id=weather_id,
        place_id=place_id,
        companion_id=companion_id,
        limit=max_per_category * 4 * 2,  # 카테고리 4개 * 여유분 2배
    )

    # 패턴 기반
    pattern_items = await retrieve_by_similar_patterns(
        mood_keywords=mood_keywords,
        limit=max_per_category * 4,
    )

    # 결합 및 중복 제거
    seen: set[int] = set()
    categorized: dict[str, list[dict]] = {
        "movie": [],
        "music": [],
        "coffee": [],
        "lighting": [],
    }

    for item in direct_items + pattern_items:
        if item["item_id"] in seen:
            continue
        seen.add(item["item_id"])
        category = item.get("category", "")
        if category in categorized and len(categorized[category]) < max_per_category * 2:
            categorized[category].append(item)

    # 점수 기준 정렬 후 제한
    for cat in categorized:
        categorized[cat].sort(key=lambda x: x["score"], reverse=True)
        categorized[cat] = categorized[cat][: max_per_category * 2]

    logger.info(
        "retrieval_complete",
        counts={cat: len(items) for cat, items in categorized.items()},
    )
    return categorized


def _label_to_category(labels: list[str]) -> str:
    label_map = {"Movie": "movie", "Music": "music", "Coffee": "coffee", "Lighting": "lighting"}
    for label in labels:
        if label in label_map:
            return label_map[label]
    return "unknown"
