import time
from datetime import datetime, timezone

import structlog

from app.core.exceptions import SyncError
from app.schemas.ingest import (
    CompanionOptionData,
    IngestItemsRequest,
    IngestOptionsRequest,
    MoodOptionData,
    PlaceOptionData,
    TimeOptionData,
    WeatherOptionData,
)
from app.schemas.sync import SyncStatusResponse, SyncTriggerResponse
from app.services.backend_client import backend_client
from app.services.ingest_service import ingest_items, ingest_options

logger = structlog.get_logger()

_last_sync: SyncStatusResponse | None = None


async def get_sync_status() -> SyncStatusResponse:
    if _last_sync is None:
        return SyncStatusResponse()
    return _last_sync


async def full_sync() -> SyncTriggerResponse:
    global _last_sync
    start = time.time()
    total_nodes = 0
    total_rels = 0

    try:
        # 1. 옵션 데이터 동기화
        logger.info("sync_options_start")
        raw_options = await backend_client.get_all_options()
        options_data = _parse_options(raw_options)
        result = await ingest_options(options_data)
        total_nodes += result.nodes_created

        # 2. 아이템 데이터 동기화 - Backend 응답 구조에 따라 파싱
        # Backend의 옵션 응답에서 아이템 목록을 추출하거나, 별도 엔드포인트 호출
        logger.info("sync_items_start")
        items_data = await _fetch_and_parse_items()
        if items_data.items:
            result = await ingest_items(items_data)
            total_nodes += result.nodes_created
            total_rels += result.relationships_created

        elapsed_ms = int((time.time() - start) * 1000)

        _last_sync = SyncStatusResponse(
            last_sync_at=datetime.now(timezone.utc),
            status="completed",
            nodes_synced=total_nodes,
            relationships_synced=total_rels,
        )

        logger.info("sync_complete", nodes=total_nodes, rels=total_rels, ms=elapsed_ms)
        return SyncTriggerResponse(
            status="completed",
            nodes_created=total_nodes,
            relationships_created=total_rels,
            duration_ms=elapsed_ms,
        )

    except Exception as e:
        logger.error("sync_error", error=str(e))
        raise SyncError(f"전체 동기화 실패: {e}") from e


def _parse_options(raw: dict) -> IngestOptionsRequest:
    """Backend 옵션 API 응답 파싱"""
    data = raw.get("data", raw)

    moods = [
        MoodOptionData(
            keyword_id=m.get("keywordId", m.get("keyword_id", 0)),
            keyword_value=m.get("keywordValue", m.get("keyword_value", m.get("name", ""))),
            category=m.get("category", ""),
        )
        for m in data.get("moods", data.get("moodKeywords", []))
    ]

    times = [
        TimeOptionData(
            time_id=t.get("timeId", t.get("time_id", 0)),
            time_key=t.get("timeKey", t.get("time_key", t.get("name", ""))),
            time_value=t.get("timeValue", t.get("time_value", "")),
        )
        for t in data.get("times", data.get("timeOptions", []))
    ]

    weathers = [
        WeatherOptionData(
            weather_id=w.get("weatherId", w.get("weather_id", 0)),
            weather_key=w.get("weatherKey", w.get("weather_key", w.get("name", ""))),
        )
        for w in data.get("weathers", data.get("weatherOptions", []))
    ]

    places = [
        PlaceOptionData(
            place_id=p.get("placeId", p.get("place_id", 0)),
            place_key=p.get("placeKey", p.get("place_key", p.get("name", ""))),
        )
        for p in data.get("places", data.get("placeOptions", []))
    ]

    companions = [
        CompanionOptionData(
            companion_id=c.get("companionId", c.get("companion_id", 0)),
            companion_key=c.get("companionKey", c.get("companion_key", c.get("name", ""))),
        )
        for c in data.get("companions", data.get("companionOptions", []))
    ]

    return IngestOptionsRequest(
        moods=moods,
        times=times,
        weathers=weathers,
        places=places,
        companions=companions,
    )


async def _fetch_and_parse_items() -> IngestItemsRequest:
    """Backend에서 아이템 목록을 가져와 파싱 (추후 Backend에 목록 API 추가 시 연동)"""
    # 현재는 빈 목록 반환 - Backend에 아이템 목록 API가 추가되면 연동
    logger.info("items_fetch_skipped", reason="아이템 목록 API 미구현 - push 방식 사용 권장")
    return IngestItemsRequest(items=[])
