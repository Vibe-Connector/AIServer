"""
RDS → Neo4j Seed Script
Fetches 100 items per category from PostgreSQL RDS and creates Neo4j nodes.

Usage:
    cd AIServer
    source .venv/bin/activate
    python scripts/seed_neo4j_from_rds.py
"""

import json
import sys
from pathlib import Path

import psycopg2
from neo4j import GraphDatabase

# ── Configuration ────────────────────────────────────────────────────────────
PG_HOST = "vibeconnector.c1y2iaugs33c.ap-northeast-2.rds.amazonaws.com"
PG_PORT = 5432
PG_DB = "postgres"
PG_USER = "postgres"
PG_PASS = "Bang)806"

NEO4J_URI = "bolt://localhost:7687"
NEO4J_USER = "neo4j"
NEO4J_PASS = "vibeconnector2024"

ITEMS_PER_CATEGORY = 100

# ── Cypher Queries ───────────────────────────────────────────────────────────

UPSERT_MOVIE = """
MERGE (m:Movie {item_id: $item_id})
SET m.item_key = $item_key,
    m.name = $name,
    m.tmdb_id = $tmdb_id,
    m.genres = $genres,
    m.keywords = $keywords,
    m.vote_average = $vote_average,
    m.runtime = $runtime,
    m.overview = $overview,
    m.image_url = $image_url,
    m.brand = $brand,
    m.external_link = $external_link,
    m.external_service = $external_service
RETURN m
"""

UPSERT_MUSIC = """
MERGE (m:Music {item_id: $item_id})
SET m.item_key = $item_key,
    m.name = $name,
    m.artists = $artists,
    m.album_name = $album_name,
    m.genres = $genres,
    m.spotify_uri = $spotify_uri,
    m.image_url = $image_url,
    m.brand = $brand,
    m.external_link = $external_link,
    m.external_service = $external_service
RETURN m
"""

UPSERT_COFFEE = """
MERGE (c:Coffee {item_id: $item_id})
SET c.item_key = $item_key,
    c.name = $name,
    c.capsule_name = $capsule_name,
    c.intensity = $intensity,
    c.roast_level = $roast_level,
    c.flavor_notes = $flavor_notes,
    c.aroma_profile = $aroma_profile,
    c.body = $body,
    c.acidity = $acidity,
    c.image_url = $image_url,
    c.brand = $brand,
    c.external_link = $external_link,
    c.external_service = $external_service
RETURN c
"""

UPSERT_LIGHTING = """
MERGE (l:Lighting {item_id: $item_id})
SET l.item_key = $item_key,
    l.name = $name,
    l.color_temp_kelvin = $color_temp_kelvin,
    l.color_temp_name = $color_temp_name,
    l.brightness_percent = $brightness_percent,
    l.lighting_type = $lighting_type,
    l.space_context = $space_context,
    l.time_context = $time_context,
    l.image_url = $image_url,
    l.brand = $brand,
    l.external_link = $external_link,
    l.external_service = $external_service
RETURN l
"""

CREATE_HAS_GENRE = """
MATCH (item {item_id: $item_id})
MERGE (g:Genre {name: $genre_name})
MERGE (item)-[:HAS_GENRE]->(g)
"""

CREATE_BELONGS_TO = """
MATCH (item {item_id: $item_id})
MATCH (c:Category {category_key: $category_key})
MERGE (item)-[:BELONGS_TO]->(c)
"""

UPSERT_CATEGORY = """
MERGE (c:Category {category_key: $category_key})
RETURN c
"""


def parse_json_field(val):
    """Parse a JSON string field from PostgreSQL, returning list or dict."""
    if val is None:
        return []
    if isinstance(val, (list, dict)):
        return val
    if isinstance(val, str):
        try:
            return json.loads(val)
        except (json.JSONDecodeError, TypeError):
            return []
    return []


def fetch_movies(cur, limit):
    cur.execute("""
        SELECT i.item_id, i.item_key, i.brand, i.image_url, i.external_link,
               i.external_service,
               md.tmdb_id, md.original_title, md.overview, md.release_date,
               md.runtime, md.vote_average, md.genres, md.keywords,
               t.item_value, t.description
        FROM items i
        JOIN movie_details md ON i.item_id = md.item_id
        LEFT JOIN item_translations t ON i.item_id = t.item_id AND t.language_id = 1
        WHERE i.is_active = true
        ORDER BY md.vote_average DESC NULLS LAST, i.item_id
        LIMIT %s
    """, (limit,))

    rows = cur.fetchall()
    items = []
    for r in rows:
        genres = parse_json_field(r[12])
        keywords = parse_json_field(r[13])
        name = r[14] or r[7] or f"Movie_{r[0]}"
        items.append({
            "item_id": r[0],
            "item_key": r[1],
            "brand": r[2],
            "image_url": r[3] or "",
            "external_link": r[4],
            "external_service": r[5] or "OTHER",
            "tmdb_id": r[6],
            "name": name,
            "overview": r[15] or r[8] or "",
            "runtime": r[10],
            "vote_average": float(r[11]) if r[11] else None,
            "genres": genres if isinstance(genres, list) else [],
            "keywords": keywords if isinstance(keywords, list) else [],
        })
    return items


def fetch_music(cur, limit):
    cur.execute("""
        SELECT i.item_id, i.item_key, i.brand, i.image_url, i.external_link,
               i.external_service,
               musd.artists, musd.album_name, musd.genres, musd.spotify_uri,
               t.item_value, t.description
        FROM items i
        JOIN music_details musd ON i.item_id = musd.item_id
        LEFT JOIN item_translations t ON i.item_id = t.item_id AND t.language_id = 1
        WHERE i.is_active = true
        ORDER BY i.item_id
        LIMIT %s
    """, (limit,))

    rows = cur.fetchall()
    items = []
    for r in rows:
        artists = parse_json_field(r[6])
        genres = parse_json_field(r[8])
        name = r[10] or r[7] or f"Music_{r[0]}"
        items.append({
            "item_id": r[0],
            "item_key": r[1],
            "brand": r[2],
            "image_url": r[3] or "",
            "external_link": r[4],
            "external_service": r[5] or "SPOTIFY",
            "name": name,
            "artists": artists if isinstance(artists, list) else [],
            "album_name": r[7] or "",
            "genres": genres if isinstance(genres, list) else [],
            "spotify_uri": r[9] or "",
        })
    return items


def fetch_coffee(cur, limit):
    cur.execute("""
        SELECT i.item_id, i.item_key, i.brand, i.image_url, i.external_link,
               i.external_service,
               cd.capsule_name, cd.intensity, cd.roast_level, cd.aroma_profile,
               cd.flavor_notes, cd.body, cd.acidity,
               t.item_value, t.description
        FROM items i
        JOIN coffee_details cd ON i.item_id = cd.item_id
        LEFT JOIN item_translations t ON i.item_id = t.item_id AND t.language_id = 1
        WHERE i.is_active = true
        ORDER BY i.item_id
        LIMIT %s
    """, (limit,))

    rows = cur.fetchall()
    items = []
    for r in rows:
        aroma = parse_json_field(r[9])
        aroma_list = aroma.get("primary", []) if isinstance(aroma, dict) else (aroma if isinstance(aroma, list) else [])
        name = r[13] or r[6] or f"Coffee_{r[0]}"
        items.append({
            "item_id": r[0],
            "item_key": r[1],
            "brand": r[2] or "Nespresso",
            "image_url": r[3] or "",
            "external_link": r[4],
            "external_service": r[5] or "NESPRESSO",
            "name": name,
            "capsule_name": r[6] or "",
            "intensity": r[7],
            "roast_level": r[8] or "",
            "flavor_notes": r[10] or "",
            "aroma_profile": aroma_list,
            "body": r[11],
            "acidity": r[12],
        })
    return items


def fetch_lighting(cur, limit):
    cur.execute("""
        SELECT i.item_id, i.item_key, i.brand, i.image_url, i.external_link,
               i.external_service,
               ld.color_temp_kelvin, ld.color_temp_name, ld.brightness_percent,
               ld.lighting_type, ld.space_context, ld.time_context,
               t.item_value, t.description
        FROM items i
        JOIN lighting_details ld ON i.item_id = ld.item_id
        LEFT JOIN item_translations t ON i.item_id = t.item_id AND t.language_id = 1
        WHERE i.is_active = true
        ORDER BY i.item_id
        LIMIT %s
    """, (limit,))

    rows = cur.fetchall()
    items = []
    for r in rows:
        name = r[12] or f"Lighting_{r[0]}"
        items.append({
            "item_id": r[0],
            "item_key": r[1],
            "brand": r[2],
            "image_url": r[3] or "",
            "external_link": r[4],
            "external_service": r[5] or "HUE",
            "name": name,
            "color_temp_kelvin": r[6],
            "color_temp_name": r[7] or "",
            "brightness_percent": r[8],
            "lighting_type": r[9] or "",
            "space_context": r[10] or "",
            "time_context": r[11] or "",
        })
    return items


def ensure_categories(neo_session):
    """Ensure Category nodes exist."""
    for key in ["video", "music", "coffee", "lighting"]:
        neo_session.run(UPSERT_CATEGORY, category_key=key)


def seed_movies(neo_session, items):
    print(f"\n[Movie] {len(items)}개 노드 생성 중...")
    for i, item in enumerate(items):
        neo_session.run(UPSERT_MOVIE, **item)
        # HAS_GENRE relationships
        for genre in item.get("genres", []):
            if genre:
                neo_session.run(CREATE_HAS_GENRE, item_id=item["item_id"], genre_name=genre)
        # BELONGS_TO
        neo_session.run(CREATE_BELONGS_TO, item_id=item["item_id"], category_key="video")
        if (i + 1) % 20 == 0 or i + 1 == len(items):
            print(f"  [{i+1}/{len(items)}] 완료")


def seed_music(neo_session, items):
    print(f"\n[Music] {len(items)}개 노드 생성 중...")
    for i, item in enumerate(items):
        neo_session.run(UPSERT_MUSIC, **item)
        for genre in item.get("genres", []):
            if genre:
                neo_session.run(CREATE_HAS_GENRE, item_id=item["item_id"], genre_name=genre)
        neo_session.run(CREATE_BELONGS_TO, item_id=item["item_id"], category_key="music")
        if (i + 1) % 20 == 0 or i + 1 == len(items):
            print(f"  [{i+1}/{len(items)}] 완료")


def seed_coffee(neo_session, items):
    print(f"\n[Coffee] {len(items)}개 노드 생성 중...")
    for i, item in enumerate(items):
        neo_session.run(UPSERT_COFFEE, **item)
        neo_session.run(CREATE_BELONGS_TO, item_id=item["item_id"], category_key="coffee")
        if (i + 1) % 20 == 0 or i + 1 == len(items):
            print(f"  [{i+1}/{len(items)}] 완료")


def seed_lighting(neo_session, items):
    print(f"\n[Lighting] {len(items)}개 노드 생성 중...")
    for i, item in enumerate(items):
        neo_session.run(UPSERT_LIGHTING, **item)
        neo_session.run(CREATE_BELONGS_TO, item_id=item["item_id"], category_key="lighting")
        if (i + 1) % 20 == 0 or i + 1 == len(items):
            print(f"  [{i+1}/{len(items)}] 완료")


def main():
    # ── Step 1: Fetch from PostgreSQL ────────────────────────────────────
    print("=" * 60)
    print("RDS → Neo4j Seed Script")
    print("=" * 60)

    print("\n[1/2] PostgreSQL에서 데이터 가져오는 중...")
    pg_conn = psycopg2.connect(
        host=PG_HOST, port=PG_PORT, dbname=PG_DB,
        user=PG_USER, password=PG_PASS,
    )
    cur = pg_conn.cursor()

    movies = fetch_movies(cur, ITEMS_PER_CATEGORY)
    print(f"  Movie: {len(movies)}개 가져옴")

    music = fetch_music(cur, ITEMS_PER_CATEGORY)
    print(f"  Music: {len(music)}개 가져옴")

    coffee = fetch_coffee(cur, ITEMS_PER_CATEGORY)
    print(f"  Coffee: {len(coffee)}개 가져옴 (최대 {ITEMS_PER_CATEGORY})")

    lighting = fetch_lighting(cur, ITEMS_PER_CATEGORY)
    print(f"  Lighting: {len(lighting)}개 가져옴")

    cur.close()
    pg_conn.close()

    total = len(movies) + len(music) + len(coffee) + len(lighting)
    print(f"\n  총 {total}개 아이템 준비 완료")

    # ── Step 2: Seed into Neo4j ──────────────────────────────────────────
    print(f"\n[2/2] Neo4j에 노드 생성 중...")
    neo_driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASS))

    with neo_driver.session() as session:
        ensure_categories(session)
        seed_movies(session, movies)
        seed_music(session, music)
        seed_coffee(session, coffee)
        seed_lighting(session, lighting)

    neo_driver.close()

    # ── Summary ──────────────────────────────────────────────────────────
    print(f"\n{'=' * 60}")
    print(f"완료!")
    print(f"  Movie:    {len(movies)}개")
    print(f"  Music:    {len(music)}개")
    print(f"  Coffee:   {len(coffee)}개")
    print(f"  Lighting: {len(lighting)}개")
    print(f"  총합:     {total}개 노드 생성/업데이트됨")
    print(f"{'=' * 60}")


if __name__ == "__main__":
    main()
