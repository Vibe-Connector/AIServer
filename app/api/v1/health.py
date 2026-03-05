from fastapi import APIRouter

from app.api.response import ApiResponse
from app.schemas.common import HealthStatus
from app.services import graph_service

router = APIRouter(tags=["Health"])


@router.get("/health")
async def health_check() -> ApiResponse:
    try:
        stats = await graph_service.get_graph_stats()
        return ApiResponse.ok(
            HealthStatus(
                status="healthy",
                neo4j="connected",
                graph_stats=stats,
            ).model_dump()
        )
    except Exception:
        return ApiResponse.ok(
            HealthStatus(
                status="degraded",
                neo4j="disconnected",
            ).model_dump()
        )
