from fastapi import APIRouter

from app.api.response import ApiResponse
from app.schemas.ingest import (
    IngestItemsRequest,
    IngestOptionsRequest,
    IngestVibeSessionRequest,
)
from app.services import ingest_service

router = APIRouter(prefix="/graph/ingest", tags=["Ingestion"])


@router.post("/options")
async def ingest_options(data: IngestOptionsRequest) -> ApiResponse:
    result = await ingest_service.ingest_options(data)
    return ApiResponse.ok(result.model_dump())


@router.post("/items")
async def ingest_items(data: IngestItemsRequest) -> ApiResponse:
    result = await ingest_service.ingest_items(data)
    return ApiResponse.ok(result.model_dump())


@router.post("/vibe-session")
async def ingest_vibe_session(data: IngestVibeSessionRequest) -> ApiResponse:
    result = await ingest_service.ingest_vibe_session(data)
    return ApiResponse.ok(result.model_dump())


@router.post("/evaluate-fitness")
async def evaluate_fitness() -> ApiResponse:
    """LLM을 사용하여 모든 아이템의 FITS_* 관계 가중치를 초기화합니다."""
    from app.services.weight_init_service import evaluate_and_create_fits
    result = await evaluate_and_create_fits(batch_size=5)
    return ApiResponse.ok(result)
