from pydantic import BaseModel


class HealthStatus(BaseModel):
    status: str
    neo4j: str
    graph_stats: dict | None = None


class GraphStats(BaseModel):
    node_count: int
    relationship_count: int
    labels: list[dict] = []
