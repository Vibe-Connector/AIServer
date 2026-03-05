# --- Node UPSERT ---

UPSERT_MOOD = """
MERGE (m:Mood {keyword_id: $keyword_id})
SET m.keyword_value = $keyword_value, m.category = $category
RETURN m
"""

UPSERT_TIME = """
MERGE (t:Time {time_id: $time_id})
SET t.time_key = $time_key, t.time_value = $time_value
RETURN t
"""

UPSERT_WEATHER = """
MERGE (w:Weather {weather_id: $weather_id})
SET w.weather_key = $weather_key
RETURN w
"""

UPSERT_PLACE = """
MERGE (p:Place {place_id: $place_id})
SET p.place_key = $place_key
RETURN p
"""

UPSERT_COMPANION = """
MERGE (c:Companion {companion_id: $companion_id})
SET c.companion_key = $companion_key
RETURN c
"""

UPSERT_CATEGORY = """
MERGE (c:Category {category_id: $category_id})
SET c.category_key = $category_key
RETURN c
"""

UPSERT_GENRE = """
MERGE (g:Genre {name: $name})
RETURN g
"""

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

# --- Relationship Creation ---

CREATE_BELONGS_TO = """
MATCH (item {item_id: $item_id})
MATCH (c:Category {category_key: $category_key})
MERGE (item)-[:BELONGS_TO]->(c)
"""

CREATE_HAS_GENRE = """
MATCH (item {item_id: $item_id})
MERGE (g:Genre {name: $genre_name})
MERGE (item)-[:HAS_GENRE]->(g)
"""

CREATE_FITS_MOOD = """
MATCH (item {item_id: $item_id})
MATCH (m:Mood {keyword_id: $keyword_id})
MERGE (item)-[r:FITS_MOOD]->(m)
SET r.weight = $weight
"""

CREATE_FITS_TIME = """
MATCH (item {item_id: $item_id})
MATCH (t:Time {time_id: $time_id})
MERGE (item)-[r:FITS_TIME]->(t)
SET r.weight = $weight
"""

CREATE_FITS_WEATHER = """
MATCH (item {item_id: $item_id})
MATCH (w:Weather {weather_id: $weather_id})
MERGE (item)-[r:FITS_WEATHER]->(w)
SET r.weight = $weight
"""

CREATE_FITS_PLACE = """
MATCH (item {item_id: $item_id})
MATCH (p:Place {place_id: $place_id})
MERGE (item)-[r:FITS_PLACE]->(p)
SET r.weight = $weight
"""

CREATE_FITS_COMPANION = """
MATCH (item {item_id: $item_id})
MATCH (c:Companion {companion_id: $companion_id})
MERGE (item)-[r:FITS_COMPANION]->(c)
SET r.weight = $weight
"""

CREATE_PAIRS_WITH = """
MATCH (a {item_id: $item_id_a})
MATCH (b {item_id: $item_id_b})
MERGE (a)-[r:PAIRS_WITH]->(b)
SET r.weight = $weight, r.reason = $reason
"""

# --- VibePattern Learning ---

UPSERT_VIBE_PATTERN = """
MERGE (v:VibePattern {pattern_id: $pattern_id})
SET v.mood_combo = $mood_combo,
    v.frequency = COALESCE(v.frequency, 0) + 1
RETURN v
"""

CREATE_SELECTED_IN = """
MATCH (node {$id_field: $id_value})
MATCH (v:VibePattern {pattern_id: $pattern_id})
MERGE (node)-[r:SELECTED_IN]->(v)
SET r.count = COALESCE(r.count, 0) + 1
"""

CREATE_RECOMMENDED_FOR = """
MATCH (item {item_id: $item_id})
MATCH (v:VibePattern {pattern_id: $pattern_id})
MERGE (item)-[r:RECOMMENDED_FOR]->(v)
SET r.score = $score, r.count = COALESCE(r.count, 0) + 1
"""

CREATE_CO_SELECTED = """
MATCH (a:Mood {keyword_id: $keyword_id_a})
MATCH (b:Mood {keyword_id: $keyword_id_b})
MERGE (a)-[r:CO_SELECTED]-(b)
SET r.count = COALESCE(r.count, 0) + 1
"""

# --- Retrieval ---

FIND_ITEMS_BY_VIBE_CONTEXT = """
MATCH (mood:Mood) WHERE mood.keyword_id IN $mood_keyword_ids
WITH collect(mood) AS moods

OPTIONAL MATCH (time:Time {time_id: $time_id})
OPTIONAL MATCH (weather:Weather {weather_id: $weather_id})
OPTIONAL MATCH (place:Place {place_id: $place_id})
OPTIONAL MATCH (companion:Companion {companion_id: $companion_id})

WITH moods, time, weather, place, companion

UNWIND moods AS mood
OPTIONAL MATCH (item)-[r1:FITS_MOOD]->(mood)
WITH item, time, weather, place, companion,
     sum(COALESCE(r1.weight, 0)) AS mood_score
WHERE item IS NOT NULL

OPTIONAL MATCH (item)-[r2:FITS_TIME]->(time)
OPTIONAL MATCH (item)-[r3:FITS_WEATHER]->(weather)
OPTIONAL MATCH (item)-[r4:FITS_PLACE]->(place)
OPTIONAL MATCH (item)-[r5:FITS_COMPANION]->(companion)

WITH item,
     mood_score +
     COALESCE(r2.weight, 0) +
     COALESCE(r3.weight, 0) +
     COALESCE(r4.weight, 0) +
     COALESCE(r5.weight, 0) AS total_score,
     labels(item) AS item_labels

WHERE total_score > $threshold
RETURN item, total_score, item_labels
ORDER BY total_score DESC
LIMIT $limit
"""

FIND_SIMILAR_PATTERNS = """
MATCH (v:VibePattern)
WHERE any(m IN v.mood_combo WHERE m IN $mood_keywords)
WITH v, size([m IN v.mood_combo WHERE m IN $mood_keywords]) AS overlap
ORDER BY overlap DESC, v.frequency DESC
LIMIT 5
MATCH (item)-[r:RECOMMENDED_FOR]->(v)
RETURN item, r.score AS score, labels(item) AS item_labels
ORDER BY r.score DESC
LIMIT $limit
"""

# --- Graph Stats ---

GET_GRAPH_STATS = """
CALL {
    MATCH (n) RETURN count(n) AS node_count
}
CALL {
    MATCH ()-[r]->() RETURN count(r) AS relationship_count
}
CALL {
    MATCH (n) UNWIND labels(n) AS label
    RETURN label, count(*) AS count ORDER BY count DESC
}
RETURN node_count, relationship_count, collect({label: label, count: count}) AS labels
"""

# --- CRUD ---

GET_NODE_BY_ID = """
MATCH (n) WHERE elementId(n) = $element_id
OPTIONAL MATCH (n)-[r]-(m)
RETURN n,
  collect({
    rel: type(r),
    direction: CASE WHEN startNode(r) = n THEN 'OUT' ELSE 'IN' END,
    node: m
  }) AS relationships
"""

LIST_NODES_BY_LABEL = """
CALL db.labels() YIELD label
WHERE $label IS NULL OR label = $label
MATCH (n) WHERE $label IN labels(n) OR $label IS NULL
RETURN n, labels(n) AS node_labels
ORDER BY elementId(n)
SKIP $skip LIMIT $limit
"""

DELETE_NODE = """
MATCH (n) WHERE elementId(n) = $element_id
DETACH DELETE n
"""

DELETE_RELATIONSHIP = """
MATCH ()-[r]->() WHERE elementId(r) = $element_id
DELETE r
"""
