from fastapi import APIRouter

from app.api.response import ApiResponse
from app.schemas.recommend import VibeRecommendRequest
from app.services import recommend_service

router = APIRouter(prefix="/recommend", tags=["Recommendation"])


@router.post("/vibe")
async def recommend_vibe(request: VibeRecommendRequest) -> ApiResponse:
    result = await recommend_service.recommend_vibe(request)
    return ApiResponse.ok(result.model_dump())
