from fastapi import APIRouter

from app.api.response import ApiResponse
from app.services import sync_service

router = APIRouter(prefix="/sync", tags=["Sync"])


@router.get("/status")
async def sync_status() -> ApiResponse:
    status = await sync_service.get_sync_status()
    return ApiResponse.ok(status.model_dump())


@router.post("/full")
async def full_sync() -> ApiResponse:
    result = await sync_service.full_sync()
    return ApiResponse.ok(result.model_dump())
