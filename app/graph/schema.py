import structlog

from app.graph.connection import get_session

logger = structlog.get_logger()

CONSTRAINTS = [
    ("CREATE CONSTRAINT mood_keyword_id IF NOT EXISTS "
     "FOR (m:Mood) REQUIRE m.keyword_id IS UNIQUE"),
    ("CREATE CONSTRAINT time_time_id IF NOT EXISTS "
     "FOR (t:Time) REQUIRE t.time_id IS UNIQUE"),
    ("CREATE CONSTRAINT weather_weather_id IF NOT EXISTS "
     "FOR (w:Weather) REQUIRE w.weather_id IS UNIQUE"),
    ("CREATE CONSTRAINT place_place_id IF NOT EXISTS "
     "FOR (p:Place) REQUIRE p.place_id IS UNIQUE"),
    ("CREATE CONSTRAINT companion_companion_id IF NOT EXISTS "
     "FOR (c:Companion) REQUIRE c.companion_id IS UNIQUE"),
    ("CREATE CONSTRAINT movie_item_id IF NOT EXISTS "
     "FOR (m:Movie) REQUIRE m.item_id IS UNIQUE"),
    ("CREATE CONSTRAINT music_item_id IF NOT EXISTS "
     "FOR (m:Music) REQUIRE m.item_id IS UNIQUE"),
    ("CREATE CONSTRAINT coffee_item_id IF NOT EXISTS "
     "FOR (c:Coffee) REQUIRE c.item_id IS UNIQUE"),
    ("CREATE CONSTRAINT lighting_item_id IF NOT EXISTS "
     "FOR (l:Lighting) REQUIRE l.item_id IS UNIQUE"),
    ("CREATE CONSTRAINT category_category_id IF NOT EXISTS "
     "FOR (c:Category) REQUIRE c.category_id IS UNIQUE"),
    ("CREATE CONSTRAINT genre_name IF NOT EXISTS "
     "FOR (g:Genre) REQUIRE g.name IS UNIQUE"),
    ("CREATE CONSTRAINT vibe_pattern_id IF NOT EXISTS "
     "FOR (v:VibePattern) REQUIRE v.pattern_id IS UNIQUE"),
]

INDEXES = [
    "CREATE INDEX mood_keyword_value IF NOT EXISTS FOR (m:Mood) ON (m.keyword_value)",
    "CREATE INDEX time_time_key IF NOT EXISTS FOR (t:Time) ON (t.time_key)",
    "CREATE INDEX weather_weather_key IF NOT EXISTS FOR (w:Weather) ON (w.weather_key)",
    "CREATE INDEX place_place_key IF NOT EXISTS FOR (p:Place) ON (p.place_key)",
    "CREATE INDEX companion_companion_key IF NOT EXISTS FOR (c:Companion) ON (c.companion_key)",
]

FULLTEXT_INDEXES = [
    (
        "CREATE FULLTEXT INDEX item_search IF NOT EXISTS "
        "FOR (n:Movie|Music|Coffee|Lighting) ON EACH [n.name, n.item_key]"
    ),
]


async def apply_schema() -> None:
    async with get_session() as session:
        for query in CONSTRAINTS + INDEXES + FULLTEXT_INDEXES:
            await session.run(query)
    logger.info(
        "graph_schema_applied",
        constraints=len(CONSTRAINTS),
        indexes=len(INDEXES),
        fulltext=len(FULLTEXT_INDEXES),
    )
