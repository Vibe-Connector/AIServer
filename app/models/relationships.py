from pydantic import BaseModel


class FitsRelationship(BaseModel):
    item_id: int
    target_id: int
    weight: float = 0.5


class PairsWithRelationship(BaseModel):
    item_id_a: int
    item_id_b: int
    weight: float = 0.5
    reason: str = ""
