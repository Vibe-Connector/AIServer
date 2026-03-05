from datetime import datetime

from pydantic import BaseModel


class SyncStatusResponse(BaseModel):
    last_sync_at: datetime | None = None
    status: str = "never"
    nodes_synced: int = 0
    relationships_synced: int = 0


class SyncTriggerResponse(BaseModel):
    status: str
    nodes_created: int = 0
    relationships_created: int = 0
    duration_ms: int = 0
