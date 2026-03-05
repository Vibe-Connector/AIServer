import structlog

from app.graph import queries
from app.graph.repository import execute_write, execute_write_batch
from app.schemas.ingest import (
    IngestItemsRequest,
    IngestOptionsRequest,
    IngestResult,
    IngestVibeSessionRequest,
    ItemData,
)

logger = structlog.get_logger()

CATEGORY_LABEL_MAP = {
    "movie": "Movie",
    "video": "Movie",
    "music": "Music",
    "coffee": "Coffee",
    "lighting": "Lighting",
}


async def ingest_options(data: IngestOptionsRequest) -> IngestResult:
    batch: list[tuple[str, dict | None]] = []

    for m in data.moods:
        batch.append((queries.UPSERT_MOOD, m.model_dump()))
    for t in data.times:
        batch.append((queries.UPSERT_TIME, t.model_dump()))
    for w in data.weathers:
        batch.append((queries.UPSERT_WEATHER, w.model_dump()))
    for p in data.places:
        batch.append((queries.UPSERT_PLACE, p.model_dump()))
    for c in data.companions:
        batch.append((queries.UPSERT_COMPANION, c.model_dump()))

    await execute_write_batch(batch)

    total = (
        len(data.moods) + len(data.times) + len(data.weathers)
        + len(data.places) + len(data.companions)
    )
    logger.info("options_ingested", count=total)
    return IngestResult(nodes_created=total, message=f"{total}개 옵션 노드 생성/업데이트")


async def _ingest_single_item(item: ItemData) -> int:
    label = CATEGORY_LABEL_MAP.get(item.category_key)
    if not label:
        logger.warning("unknown_category", category=item.category_key)
        return 0

    details = item.details
    params = {
        "item_id": item.item_id,
        "item_key": item.item_key,
        "name": item.name,
        "image_url": item.image_url,
        "brand": details.get("brand"),
        "external_link": details.get("external_link"),
        "external_service": details.get("external_service"),
    }

    rel_count = 0

    if label == "Movie":
        params.update(
            tmdb_id=details.get("tmdb_id"),
            genres=details.get("genres", []),
            keywords=details.get("keywords", []),
            vote_average=details.get("vote_average"),
            runtime=details.get("runtime"),
            overview=details.get("overview", ""),
        )
        await execute_write(queries.UPSERT_MOVIE, params)
        for genre in params["genres"]:
            await execute_write(
                queries.CREATE_HAS_GENRE,
                {"item_id": item.item_id, "genre_name": genre},
            )
            rel_count += 1

    elif label == "Music":
        params.update(
            artists=details.get("artists", []),
            album_name=details.get("album_name", ""),
            genres=details.get("genres", []),
            spotify_uri=details.get("spotify_uri", ""),
        )
        await execute_write(queries.UPSERT_MUSIC, params)
        for genre in params["genres"]:
            await execute_write(
                queries.CREATE_HAS_GENRE,
                {"item_id": item.item_id, "genre_name": genre},
            )
            rel_count += 1

    elif label == "Coffee":
        params.update(
            capsule_name=details.get("capsule_name", ""),
            intensity=details.get("intensity"),
            roast_level=details.get("roast_level", ""),
            flavor_notes=details.get("flavor_notes", ""),
            aroma_profile=details.get("aroma_profile", []),
            body=details.get("body"),
            acidity=details.get("acidity"),
        )
        await execute_write(queries.UPSERT_COFFEE, params)

    elif label == "Lighting":
        params.update(
            color_temp_kelvin=details.get("color_temp_kelvin"),
            color_temp_name=details.get("color_temp_name", ""),
            brightness_percent=details.get("brightness_percent"),
            lighting_type=details.get("lighting_type", ""),
            space_context=details.get("space_context", ""),
            time_context=details.get("time_context", ""),
        )
        await execute_write(queries.UPSERT_LIGHTING, params)

    return rel_count


async def ingest_items(data: IngestItemsRequest) -> IngestResult:
    total_rels = 0
    for item in data.items:
        total_rels += await _ingest_single_item(item)

    logger.info("items_ingested", count=len(data.items), relationships=total_rels)
    return IngestResult(
        nodes_created=len(data.items),
        relationships_created=total_rels,
        message=f"{len(data.items)}개 아이템 노드, {total_rels}개 관계 생성/업데이트",
    )


async def ingest_vibe_session(data: IngestVibeSessionRequest) -> IngestResult:
    sorted_moods = sorted(data.mood_keywords)
    pattern_id = (
        f"{'-'.join(sorted_moods)}"
        f"_{data.time_key}_{data.weather_key}"
        f"_{data.place_key}_{data.companion_key}"
    )

    await execute_write(
        queries.UPSERT_VIBE_PATTERN,
        {"pattern_id": pattern_id, "mood_combo": sorted_moods},
    )

    rel_count = 0

    # CO_SELECTED between mood keywords
    for i, kid_a in enumerate(data.mood_keyword_ids):
        for kid_b in data.mood_keyword_ids[i + 1 :]:
            await execute_write(
                queries.CREATE_CO_SELECTED,
                {"keyword_id_a": kid_a, "keyword_id_b": kid_b},
            )
            rel_count += 1

    # RECOMMENDED_FOR
    for item_id in data.recommended_item_ids:
        await execute_write(
            queries.CREATE_RECOMMENDED_FOR,
            {"item_id": item_id, "pattern_id": pattern_id, "score": 1.0},
        )
        rel_count += 1

    logger.info("vibe_session_ingested", session_id=data.session_id, pattern=pattern_id)
    return IngestResult(
        nodes_created=1,
        relationships_created=rel_count,
        message=f"VibePattern '{pattern_id}' 생성/업데이트, {rel_count}개 관계",
    )
