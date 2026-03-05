from fastapi import APIRouter

from app.api.v1 import graph, health, ingest, recommend, sync

v1_router = APIRouter(prefix="/api/v1")

v1_router.include_router(health.router)
v1_router.include_router(ingest.router)
v1_router.include_router(recommend.router)
v1_router.include_router(graph.router)
v1_router.include_router(sync.router)
