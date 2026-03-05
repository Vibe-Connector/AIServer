import structlog

from app.rag.chain import run_recommend_chain
from app.schemas.recommend import VibeRecommendRequest, VibeRecommendResponse

logger = structlog.get_logger()


async def recommend_vibe(request: VibeRecommendRequest) -> VibeRecommendResponse:
    logger.info(
        "recommend_start",
        moods=request.mood_keywords,
        time=request.time_key,
        weather=request.weather_key,
        place=request.place_key,
        companion=request.companion_key,
    )

    response = await run_recommend_chain(request)

    logger.info(
        "recommend_done",
        processing_time_ms=response.processing_time_ms,
        categories={cat.category_key: len(cat.items) for cat in response.recommendations},
    )

    return response
