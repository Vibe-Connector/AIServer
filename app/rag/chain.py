import time

import structlog

from app.rag.context_builder import build_context
from app.rag.graph_retriever import retrieve_all
from app.schemas.recommend import (
    CategoryRecommendation,
    RecommendedItem,
    VibeRecommendRequest,
    VibeRecommendResponse,
)
from app.services import llm_service

logger = structlog.get_logger()


async def run_recommend_chain(request: VibeRecommendRequest) -> VibeRecommendResponse:
    """GraphRAG 추천 체인 실행: 그래프 검색 -> 컨텍스트 빌드 -> LLM 호출"""
    start = time.time()

    # 1. 그래프에서 후보 아이템 검색
    categorized_items = await retrieve_all(
        mood_keyword_ids=request.mood_keyword_ids,
        mood_keywords=request.mood_keywords,
        time_id=request.time_id,
        weather_id=request.weather_id,
        place_id=request.place_id,
        companion_id=request.companion_id,
        max_per_category=request.max_items_per_category,
    )

    total_candidates = sum(len(items) for items in categorized_items.values())
    logger.info("candidates_retrieved", total=total_candidates)

    # 2. 컨텍스트 빌드
    context_text = build_context(categorized_items)

    # 3. LLM 호출
    llm_result = await llm_service.generate_recommendation(
        graph_context=context_text,
        mood_keywords=request.mood_keywords,
        time_key=request.time_key,
        weather_key=request.weather_key,
        place_key=request.place_key,
        companion_key=request.companion_key,
    )

    # 4. 응답 구성
    recommendations = _build_recommendations(llm_result, categorized_items)
    elapsed_ms = int((time.time() - start) * 1000)

    return VibeRecommendResponse(
        phrase=llm_result.get("phrase", ""),
        analysis=llm_result.get("analysis", ""),
        recommendations=recommendations,
        processing_time_ms=elapsed_ms,
        graph_context={
            "total_candidates": total_candidates,
            "candidates_per_category": {
                cat: len(items) for cat, items in categorized_items.items()
            },
        },
    )


def _build_recommendations(
    llm_result: dict,
    categorized_items: dict[str, list[dict]],
) -> list[CategoryRecommendation]:
    """LLM 결과와 그래프 데이터를 결합하여 최종 추천 목록 생성"""
    result: list[CategoryRecommendation] = []
    selections = llm_result.get("selections", {})

    # 카테고리별 item_id -> item 맵 생성
    item_maps: dict[str, dict[int, dict]] = {}
    for cat, items in categorized_items.items():
        item_maps[cat] = {item["item_id"]: item for item in items}

    for category in ["movie", "music", "coffee", "lighting"]:
        cat_selections = selections.get(category, [])
        cat_items = item_maps.get(category, {})
        rec_list: list[RecommendedItem] = []

        for sel in cat_selections:
            item_id = sel.get("item_id")
            reason = sel.get("reason", "")

            if item_id and item_id in cat_items:
                graph_item = cat_items[item_id]
                props = graph_item.get("properties", {})
                rec_list.append(
                    RecommendedItem(
                        item_id=item_id,
                        item_key=graph_item.get("item_key", ""),
                        name=graph_item.get("name", ""),
                        category=category,
                        relevance_score=graph_item.get("score", 0.0),
                        reason=reason,
                        image_url=graph_item.get("image_url", ""),
                        brand=props.get("brand"),
                        external_link=props.get("external_link"),
                        external_service=props.get("external_service"),
                    )
                )

        # LLM이 선택하지 않은 경우 그래프 점수 기반 폴백
        if not rec_list and cat_items:
            sorted_items = sorted(cat_items.values(), key=lambda x: x.get("score", 0), reverse=True)
            for item in sorted_items[:3]:
                props = item.get("properties", {})
                rec_list.append(
                    RecommendedItem(
                        item_id=item["item_id"],
                        item_key=item.get("item_key", ""),
                        name=item.get("name", ""),
                        category=category,
                        relevance_score=item.get("score", 0.0),
                        reason="그래프 점수 기반 자동 추천",
                        image_url=item.get("image_url", ""),
                        brand=props.get("brand"),
                        external_link=props.get("external_link"),
                        external_service=props.get("external_service"),
                    )
                )

        result.append(CategoryRecommendation(category_key=category, items=rec_list))

    return result
