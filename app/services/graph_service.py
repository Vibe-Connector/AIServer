import re
from typing import Any

import structlog

from app.core.exceptions import GraphNotFoundError
from app.graph import queries
from app.graph.repository import execute_read, execute_write
from app.schemas.graph import (
    ALLOWED_NODE_LABELS,
    ALLOWED_RELATIONSHIP_TYPES,
    NodeCreate,
    NodeResponse,
    RelationshipCreate,
)

logger = structlog.get_logger()

_SAFE_IDENTIFIER = re.compile(r"^[a-zA-Z_][a-zA-Z0-9_]*$")


def _assert_safe_identifier(value: str, context: str) -> None:
    """런타임 방어: 식별자가 안전한 형태인지 검증"""
    if not _SAFE_IDENTIFIER.match(value):
        raise ValueError(f"{context}에 허용되지 않는 문자가 포함되어 있습니다: '{value}'")


def _assert_safe_property_keys(properties: dict[str, Any]) -> None:
    """런타임 방어: 모든 속성 키가 안전한 식별자인지 검증"""
    for key in properties:
        _assert_safe_identifier(key, "속성 키")


async def get_graph_stats() -> dict:
    records = await execute_read(queries.GET_GRAPH_STATS)
    if not records:
        return {"node_count": 0, "relationship_count": 0, "labels": []}
    record = records[0]
    return {
        "node_count": record["node_count"],
        "relationship_count": record["relationship_count"],
        "labels": record["labels"],
    }


async def get_node(element_id: str) -> NodeResponse:
    records = await execute_read(queries.GET_NODE_BY_ID, {"element_id": element_id})
    if not records:
        raise GraphNotFoundError(f"노드를 찾을 수 없습니다: {element_id}")
    record = records[0]
    node = record["n"]
    return NodeResponse(
        element_id=node.element_id,
        labels=list(node.labels),
        properties=dict(node),
        relationships=record["relationships"],
    )


async def create_node(data: NodeCreate) -> NodeResponse:
    # Pydantic validator가 이미 검증하지만, defense-in-depth로 재검증
    if data.label not in ALLOWED_NODE_LABELS:
        raise ValueError(f"허용되지 않는 노드 라벨: '{data.label}'")
    _assert_safe_property_keys(data.properties)

    props = ", ".join(f"{k}: ${k}" for k in data.properties)
    query = f"CREATE (n:{data.label} {{{props}}}) RETURN n"
    records = await execute_write(query, data.properties)
    node = records[0]["n"]
    return NodeResponse(
        element_id=node.element_id,
        labels=list(node.labels),
        properties=dict(node),
    )


async def update_node(element_id: str, properties: dict[str, Any]) -> NodeResponse:
    _assert_safe_property_keys(properties)

    set_clause = ", ".join(f"n.{k} = ${k}" for k in properties)
    query = f"MATCH (n) WHERE elementId(n) = $element_id SET {set_clause} RETURN n"
    params = {"element_id": element_id, **properties}
    records = await execute_write(query, params)
    if not records:
        raise GraphNotFoundError(f"노드를 찾을 수 없습니다: {element_id}")
    node = records[0]["n"]
    return NodeResponse(
        element_id=node.element_id,
        labels=list(node.labels),
        properties=dict(node),
    )


async def delete_node(element_id: str) -> None:
    await execute_write(queries.DELETE_NODE, {"element_id": element_id})


async def create_relationship(data: RelationshipCreate) -> dict:
    # Pydantic validator가 이미 검증하지만, defense-in-depth로 재검증
    if data.rel_type not in ALLOWED_RELATIONSHIP_TYPES:
        raise ValueError(f"허용되지 않는 관계 타입: '{data.rel_type}'")

    query = (
        f"MATCH (a) WHERE elementId(a) = $from_id "
        f"MATCH (b) WHERE elementId(b) = $to_id "
        f"CREATE (a)-[r:{data.rel_type} $props]->(b) "
        f"RETURN type(r) AS rel_type, elementId(r) AS rel_id"
    )
    params = {
        "from_id": data.from_element_id,
        "to_id": data.to_element_id,
        "props": data.properties,
    }
    records = await execute_write(query, params)
    if not records:
        raise GraphNotFoundError("관계 생성 대상 노드를 찾을 수 없습니다")
    return {"rel_type": records[0]["rel_type"], "rel_id": records[0]["rel_id"]}


async def delete_relationship(element_id: str) -> None:
    await execute_write(queries.DELETE_RELATIONSHIP, {"element_id": element_id})


async def list_nodes(label: str | None = None, skip: int = 0, limit: int = 50) -> list[dict]:
    if label:
        if label not in ALLOWED_NODE_LABELS:
            raise ValueError(f"허용되지 않는 노드 라벨: '{label}'")
        query = (
            f"MATCH (n:{label}) RETURN n, labels(n) AS node_labels "
            f"ORDER BY elementId(n) SKIP $skip LIMIT $limit"
        )
    else:
        query = (
            "MATCH (n) RETURN n, labels(n) AS node_labels "
            "ORDER BY elementId(n) SKIP $skip LIMIT $limit"
        )
    records = await execute_read(query, {"skip": skip, "limit": limit})
    return [
        {
            "element_id": r["n"].element_id,
            "labels": r["node_labels"],
            "properties": dict(r["n"]),
        }
        for r in records
    ]


async def execute_cypher(query: str, parameters: dict[str, Any] | None = None) -> list[dict]:
    # 위험: 임의 Cypher 실행 — 쓰기 작업 차단
    _query_upper = query.strip().upper()
    for keyword in ("CREATE", "MERGE", "DELETE", "DETACH", "SET", "REMOVE", "DROP", "CALL"):
        if keyword in _query_upper:
            raise ValueError(
                f"execute_cypher는 읽기 전용입니다. "
                f"쓰기 키워드 '{keyword}'가 포함된 쿼리는 실행할 수 없습니다."
            )

    records = await execute_read(query, parameters)
    results = []
    for record in records:
        row = {}
        for key in record.keys():
            val = record[key]
            if hasattr(val, "element_id"):
                row[key] = {"element_id": val.element_id, "properties": dict(val)}
            else:
                row[key] = val
        results.append(row)
    return results
