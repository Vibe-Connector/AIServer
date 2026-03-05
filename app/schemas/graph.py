from typing import Any

from pydantic import BaseModel


class NodeCreate(BaseModel):
    label: str
    properties: dict[str, Any]


class NodeUpdate(BaseModel):
    properties: dict[str, Any]


class RelationshipCreate(BaseModel):
    from_element_id: str
    to_element_id: str
    rel_type: str
    properties: dict[str, Any] = {}


class NodeResponse(BaseModel):
    element_id: str
    labels: list[str]
    properties: dict[str, Any]
    relationships: list[dict] = []


class CypherQueryRequest(BaseModel):
    query: str
    parameters: dict[str, Any] = {}
