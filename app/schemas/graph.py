import re
from typing import Any

from pydantic import BaseModel, field_validator

# Neo4j 노드 라벨 허용 목록
ALLOWED_NODE_LABELS = frozenset({
    "Mood", "Time", "Weather", "Place", "Companion",
    "Category", "Genre", "VibePattern",
    "Movie", "Music", "Coffee", "Lighting",
})

# Neo4j 관계 타입 허용 목록
ALLOWED_RELATIONSHIP_TYPES = frozenset({
    "BELONGS_TO", "HAS_GENRE",
    "FITS_MOOD", "FITS_TIME", "FITS_WEATHER", "FITS_PLACE", "FITS_COMPANION",
    "PAIRS_WITH", "SELECTED_IN", "RECOMMENDED_FOR", "CO_SELECTED",
})

# 속성 키 안전 패턴: 알파벳, 숫자, 언더스코어만 허용
_SAFE_IDENTIFIER = re.compile(r"^[a-zA-Z_][a-zA-Z0-9_]*$")


def _validate_property_keys(properties: dict[str, Any]) -> dict[str, Any]:
    for key in properties:
        if not _SAFE_IDENTIFIER.match(key):
            raise ValueError(
                f"속성 키 '{key}'에 허용되지 않는 문자가 포함되어 있습니다. "
                "영문자, 숫자, 언더스코어만 사용할 수 있습니다."
            )
    return properties


class NodeCreate(BaseModel):
    label: str
    properties: dict[str, Any]

    @field_validator("label")
    @classmethod
    def label_must_be_allowed(cls, v: str) -> str:
        if v not in ALLOWED_NODE_LABELS:
            raise ValueError(
                f"허용되지 않는 노드 라벨입니다: '{v}'. "
                f"허용 목록: {sorted(ALLOWED_NODE_LABELS)}"
            )
        return v

    @field_validator("properties")
    @classmethod
    def properties_keys_must_be_safe(cls, v: dict[str, Any]) -> dict[str, Any]:
        return _validate_property_keys(v)


class NodeUpdate(BaseModel):
    properties: dict[str, Any]

    @field_validator("properties")
    @classmethod
    def properties_keys_must_be_safe(cls, v: dict[str, Any]) -> dict[str, Any]:
        return _validate_property_keys(v)


class RelationshipCreate(BaseModel):
    from_element_id: str
    to_element_id: str
    rel_type: str
    properties: dict[str, Any] = {}

    @field_validator("rel_type")
    @classmethod
    def rel_type_must_be_allowed(cls, v: str) -> str:
        if v not in ALLOWED_RELATIONSHIP_TYPES:
            raise ValueError(
                f"허용되지 않는 관계 타입입니다: '{v}'. "
                f"허용 목록: {sorted(ALLOWED_RELATIONSHIP_TYPES)}"
            )
        return v

    @field_validator("properties")
    @classmethod
    def properties_keys_must_be_safe(cls, v: dict[str, Any]) -> dict[str, Any]:
        return _validate_property_keys(v)


class NodeResponse(BaseModel):
    element_id: str
    labels: list[str]
    properties: dict[str, Any]
    relationships: list[dict] = []


class CypherQueryRequest(BaseModel):
    query: str
    parameters: dict[str, Any] = {}
