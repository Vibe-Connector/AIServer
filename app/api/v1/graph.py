from fastapi import APIRouter, Query

from app.api.response import ApiResponse
from app.schemas.graph import CypherQueryRequest, NodeCreate, NodeUpdate, RelationshipCreate
from app.services import graph_service

router = APIRouter(prefix="/graph", tags=["Graph Management"])


@router.get("/stats")
async def get_stats() -> ApiResponse:
    stats = await graph_service.get_graph_stats()
    return ApiResponse.ok(stats)


@router.get("/nodes")
async def list_nodes(
    label: str | None = Query(None),
    skip: int = Query(0, ge=0),
    limit: int = Query(50, ge=1, le=200),
) -> ApiResponse:
    nodes = await graph_service.list_nodes(label=label, skip=skip, limit=limit)
    return ApiResponse.ok(nodes)


@router.get("/nodes/{element_id:path}")
async def get_node(element_id: str) -> ApiResponse:
    node = await graph_service.get_node(element_id)
    return ApiResponse.ok(node.model_dump())


@router.post("/nodes")
async def create_node(data: NodeCreate) -> ApiResponse:
    node = await graph_service.create_node(data)
    return ApiResponse.ok(node.model_dump())


@router.put("/nodes/{element_id:path}")
async def update_node(element_id: str, data: NodeUpdate) -> ApiResponse:
    node = await graph_service.update_node(element_id, data.properties)
    return ApiResponse.ok(node.model_dump())


@router.delete("/nodes/{element_id:path}")
async def delete_node(element_id: str) -> ApiResponse:
    await graph_service.delete_node(element_id)
    return ApiResponse.ok({"message": "노드가 삭제되었습니다"})


@router.post("/relationships")
async def create_relationship(data: RelationshipCreate) -> ApiResponse:
    result = await graph_service.create_relationship(data)
    return ApiResponse.ok(result)


@router.delete("/relationships/{element_id:path}")
async def delete_relationship(element_id: str) -> ApiResponse:
    await graph_service.delete_relationship(element_id)
    return ApiResponse.ok({"message": "관계가 삭제되었습니다"})


@router.post("/query")
async def execute_query(data: CypherQueryRequest) -> ApiResponse:
    results = await graph_service.execute_cypher(data.query, data.parameters)
    return ApiResponse.ok(results)
