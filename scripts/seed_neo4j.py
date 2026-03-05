"""
Neo4j 지식 그래프 시드 스크립트 - mock-data-v3.2.sql 기반.

사용법:
    cd AIServer
    python -m scripts.seed_neo4j              # 노드만 생성
    python -m scripts.seed_neo4j --with-fits  # 노드 + LLM FITS_* 관계까지

옵션 노드, 아이템 노드, 카테고리 노드, 장르 관계를 생성합니다.
--with-fits 옵션 시 LLM으로 FITS_* 관계 가중치도 초기화합니다.
"""

import argparse
import asyncio
import time

from app.config import settings
from app.core.logging import setup_logging
from app.graph import queries
from app.graph.connection import close_driver, init_driver
from app.graph.repository import execute_write, execute_write_batch
from app.graph.schema import apply_schema

# ============================================================
# Mock Data (extracted from mock-data-v3.2.sql)
# ============================================================

MOODS = [
    {"keyword_id": 1, "keyword_value": "cozy", "category": "감정"},
    {"keyword_id": 2, "keyword_value": "dreamy", "category": "분위기"},
    {"keyword_id": 3, "keyword_value": "languid", "category": "감정"},
    {"keyword_id": 4, "keyword_value": "crisp", "category": "에너지"},
    {"keyword_id": 5, "keyword_value": "melancholic", "category": "감정"},
    {"keyword_id": 6, "keyword_value": "energetic", "category": "에너지"},
    {"keyword_id": 7, "keyword_value": "serene", "category": "분위기"},
    {"keyword_id": 8, "keyword_value": "nostalgic", "category": "감정"},
    {"keyword_id": 9, "keyword_value": "focused", "category": "에너지"},
    {"keyword_id": 10, "keyword_value": "whimsical", "category": "에너지"},
    {"keyword_id": 11, "keyword_value": "romantic", "category": "분위기"},
    {"keyword_id": 12, "keyword_value": "mysterious", "category": "분위기"},
    {"keyword_id": 13, "keyword_value": "warm", "category": "감정"},
    {"keyword_id": 14, "keyword_value": "refreshing", "category": "에너지"},
    {"keyword_id": 15, "keyword_value": "contemplative", "category": "분위기"},
]

TIMES = [
    {"time_id": 1, "time_key": "dawn", "time_value": "04:00:00"},
    {"time_id": 2, "time_key": "early_morning", "time_value": "06:00:00"},
    {"time_id": 3, "time_key": "morning", "time_value": "08:00:00"},
    {"time_id": 4, "time_key": "mid_morning", "time_value": "10:00:00"},
    {"time_id": 5, "time_key": "late_morning", "time_value": "11:00:00"},
    {"time_id": 6, "time_key": "noon", "time_value": "12:00:00"},
    {"time_id": 7, "time_key": "early_afternoon", "time_value": "13:00:00"},
    {"time_id": 8, "time_key": "afternoon", "time_value": "14:30:00"},
    {"time_id": 9, "time_key": "mid_afternoon", "time_value": "16:00:00"},
    {"time_id": 10, "time_key": "late_afternoon", "time_value": "17:30:00"},
    {"time_id": 11, "time_key": "evening", "time_value": "19:00:00"},
    {"time_id": 12, "time_key": "night", "time_value": "21:00:00"},
    {"time_id": 13, "time_key": "late_night", "time_value": "23:00:00"},
    {"time_id": 14, "time_key": "midnight", "time_value": "00:00:00"},
    {"time_id": 15, "time_key": "small_hours", "time_value": "02:00:00"},
]

WEATHERS = [
    {"weather_id": 1, "weather_key": "sunny"},
    {"weather_id": 2, "weather_key": "cloudy"},
    {"weather_id": 3, "weather_key": "rainy"},
    {"weather_id": 4, "weather_key": "snowy"},
    {"weather_id": 5, "weather_key": "windy"},
    {"weather_id": 6, "weather_key": "foggy"},
    {"weather_id": 7, "weather_key": "stormy"},
    {"weather_id": 8, "weather_key": "drizzle"},
    {"weather_id": 9, "weather_key": "humid"},
    {"weather_id": 10, "weather_key": "dry"},
    {"weather_id": 11, "weather_key": "chilly"},
    {"weather_id": 12, "weather_key": "hot"},
    {"weather_id": 13, "weather_key": "mild"},
    {"weather_id": 14, "weather_key": "hazy"},
    {"weather_id": 15, "weather_key": "thunderstorm"},
]

PLACES = [
    {"place_id": 1, "place_key": "home"},
    {"place_id": 2, "place_key": "cafe"},
    {"place_id": 3, "place_key": "office"},
    {"place_id": 4, "place_key": "park"},
    {"place_id": 5, "place_key": "beach"},
    {"place_id": 6, "place_key": "mountain"},
    {"place_id": 7, "place_key": "library"},
    {"place_id": 8, "place_key": "restaurant"},
    {"place_id": 9, "place_key": "bar"},
    {"place_id": 10, "place_key": "studio"},
    {"place_id": 11, "place_key": "bedroom"},
    {"place_id": 12, "place_key": "rooftop"},
    {"place_id": 13, "place_key": "car"},
    {"place_id": 14, "place_key": "train"},
    {"place_id": 15, "place_key": "bookstore"},
]

COMPANIONS = [
    {"companion_id": 1, "companion_key": "alone"},
    {"companion_id": 2, "companion_key": "partner"},
    {"companion_id": 3, "companion_key": "friends"},
    {"companion_id": 4, "companion_key": "family"},
    {"companion_id": 5, "companion_key": "pet"},
    {"companion_id": 6, "companion_key": "colleagues"},
    {"companion_id": 7, "companion_key": "child"},
    {"companion_id": 8, "companion_key": "parents"},
    {"companion_id": 9, "companion_key": "sibling"},
    {"companion_id": 10, "companion_key": "best_friend"},
    {"companion_id": 11, "companion_key": "stranger"},
    {"companion_id": 12, "companion_key": "mentor"},
    {"companion_id": 13, "companion_key": "group"},
    {"companion_id": 14, "companion_key": "date"},
    {"companion_id": 15, "companion_key": "classmates"},
]

CATEGORIES = [
    {"category_id": 1, "category_key": "video"},
    {"category_id": 2, "category_key": "music"},
    {"category_id": 3, "category_key": "lighting"},
    {"category_id": 4, "category_key": "coffee"},
]

MOVIES = [
    {
        "item_id": 1, "item_key": "movie_tmdb_496243", "name": "기생충",
        "tmdb_id": 496243, "genres": ["드라마", "스릴러", "코미디"],
        "keywords": ["계급", "빈부격차"],
        "vote_average": 8.5, "runtime": 132,
        "overview": "전원 백수인 기택 가족이 부유한 박 사장네 집에 하나씩 침투하면서 벌어지는 이야기",
        "image_url": "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
        "brand": None, "external_link": "https://www.netflix.com/title/81257639", "external_service": "NETFLIX",
    },
    {
        "item_id": 2, "item_key": "movie_tmdb_670", "name": "올드보이",
        "tmdb_id": 670, "genres": ["스릴러", "미스터리", "드라마"],
        "keywords": ["복수", "감금"],
        "vote_average": 8.3, "runtime": 120,
        "overview": "이유도 모른 채 15년간 감금된 남자의 처절한 복수극",
        "image_url": "https://image.tmdb.org/t/p/w500/uUwMwJzFmPDFmcGJfFGEq7MbX0n.jpg",
        "brand": None, "external_link": "https://watcha.com/contents/m1234", "external_service": "OTHER",
    },
    {
        "item_id": 3, "item_key": "movie_tmdb_396535", "name": "부산행",
        "tmdb_id": 396535, "genres": ["액션", "호러", "스릴러"],
        "keywords": ["좀비", "기차"],
        "vote_average": 7.8, "runtime": 118,
        "overview": "부산행 KTX에서 벌어지는 좀비 바이러스 서바이벌",
        "image_url": "https://image.tmdb.org/t/p/w500/kFCjfRvMCFkYBQoIONOBwbQmMP3.jpg",
        "brand": None, "external_link": "https://www.netflix.com/title/80108983", "external_service": "NETFLIX",
    },
    {
        "item_id": 4, "item_key": "movie_tmdb_615643", "name": "미나리",
        "tmdb_id": 615643, "genres": ["드라마"],
        "keywords": ["이민", "가족"],
        "vote_average": 7.5, "runtime": 115,
        "overview": "아칸소주 시골로 이주한 한국인 가족의 아메리칸 드림",
        "image_url": "https://image.tmdb.org/t/p/w500/7RyBmEpegJDjOEGOUkNPpC5HBIL.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 5, "item_key": "movie_tmdb_906221", "name": "헤어질 결심",
        "tmdb_id": 906221, "genres": ["미스터리", "로맨스", "드라마"],
        "keywords": ["형사", "용의자"],
        "vote_average": 7.3, "runtime": 138,
        "overview": "산악 사고 사건을 조사하는 형사가 용의자에게 빠져드는 미스터리 로맨스",
        "image_url": "https://image.tmdb.org/t/p/w500/tRF6Mhh0I6jr7VpNzH9GJRzIfPU.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 6, "item_key": "movie_tmdb_157336", "name": "인터스텔라",
        "tmdb_id": 157336, "genres": ["SF", "드라마", "모험"],
        "keywords": ["우주", "시간여행"],
        "vote_average": 8.6, "runtime": 169,
        "overview": "인류의 생존을 위해 웜홀을 통과해 새로운 행성을 찾는 우주 탐험",
        "image_url": "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
        "brand": None, "external_link": "https://www.netflix.com/title/70305903", "external_service": "NETFLIX",
    },
    {
        "item_id": 7, "item_key": "movie_tmdb_313369", "name": "라라랜드",
        "tmdb_id": 313369, "genres": ["뮤지컬", "로맨스", "드라마"],
        "keywords": ["꿈", "재즈"],
        "vote_average": 7.9, "runtime": 128,
        "overview": "재즈 피아니스트와 배우 지망생의 꿈과 사랑 이야기",
        "image_url": "https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 8, "item_key": "movie_tmdb_27205", "name": "인셉션",
        "tmdb_id": 27205, "genres": ["SF", "액션", "스릴러"],
        "keywords": ["꿈", "무의식"],
        "vote_average": 8.4, "runtime": 148,
        "overview": "타인의 꿈에 침투해 아이디어를 심는 마인드 하이스트",
        "image_url": "https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg",
        "brand": None, "external_link": "https://www.netflix.com/title/70131314", "external_service": "NETFLIX",
    },
    {
        "item_id": 9, "item_key": "movie_tmdb_19995", "name": "아바타",
        "tmdb_id": 19995, "genres": ["SF", "모험", "액션"],
        "keywords": ["외계행성", "생태"],
        "vote_average": 7.6, "runtime": 162,
        "overview": "판도라 행성에서 벌어지는 장대한 SF 서사시",
        "image_url": "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki98lbIIv.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 10, "item_key": "movie_tmdb_603", "name": "매트릭스",
        "tmdb_id": 603, "genres": ["SF", "액션"],
        "keywords": ["가상현실", "사이버펑크"],
        "vote_average": 8.2, "runtime": 136,
        "overview": "가상현실과 현실의 경계를 묻는 사이버펑크 액션",
        "image_url": "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 11, "item_key": "movie_tmdb_1072790", "name": "서울의 봄",
        "tmdb_id": 1072790, "genres": ["드라마", "역사"],
        "keywords": ["군사반란", "12.12"],
        "vote_average": 8.0, "runtime": 141,
        "overview": "1979년 12.12 군사반란을 다룬 역사 드라마",
        "image_url": "https://image.tmdb.org/t/p/w500/sKqBiGaIPTp0s2LOz0yzW3BJNQT.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 12, "item_key": "movie_tmdb_1115396", "name": "범죄도시4",
        "tmdb_id": 1115396, "genres": ["액션", "범죄"],
        "keywords": ["형사", "범죄소탕"],
        "vote_average": 7.0, "runtime": 109,
        "overview": "마석도 형사의 통쾌한 범죄 소탕 액션",
        "image_url": "https://image.tmdb.org/t/p/w500/placeholder12.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 13, "item_key": "movie_tmdb_1116173", "name": "파묘",
        "tmdb_id": 1116173, "genres": ["미스터리", "호러"],
        "keywords": ["풍수", "오컬트"],
        "vote_average": 7.2, "runtime": 134,
        "overview": "풍수사와 장의사가 벌이는 미스터리 오컬트",
        "image_url": "https://image.tmdb.org/t/p/w500/placeholder13.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 14, "item_key": "movie_tmdb_1815", "name": "괴물",
        "tmdb_id": 1815, "genres": ["SF", "호러", "코미디"],
        "keywords": ["괴생명체", "한강"],
        "vote_average": 7.1, "runtime": 119,
        "overview": "한강에 나타난 괴생명체와 가족의 사투",
        "image_url": "https://image.tmdb.org/t/p/w500/placeholder14.jpg",
        "brand": None, "external_link": "https://www.netflix.com/title/70076013", "external_service": "NETFLIX",
    },
    {
        "item_id": 15, "item_key": "movie_tmdb_442168", "name": "택시운전사",
        "tmdb_id": 442168, "genres": ["드라마", "역사"],
        "keywords": ["광주", "실화"],
        "vote_average": 7.9, "runtime": 137,
        "overview": "1980년 광주를 목격한 택시기사의 실화 기반 드라마",
        "image_url": "https://image.tmdb.org/t/p/w500/placeholder15.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
]

MUSIC = [
    {
        "item_id": 16, "item_key": "music_spring_day", "name": "봄날",
        "artists": ["BTS"], "album_name": "화양연화 Young Forever",
        "genres": ["K-Pop", "발라드"], "spotify_uri": "spotify:track:0xqiGOyDpB1JMa0on01dEr",
        "image_url": "https://cdn.vibelink.com/music/16.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/0xqiGOyDpB1JMa0on01dEr", "external_service": "SPOTIFY",
    },
    {
        "item_id": 17, "item_key": "music_dynamite", "name": "Dynamite",
        "artists": ["BTS"], "album_name": "Dynamite (DayTime Version)",
        "genres": ["K-Pop", "디스코"], "spotify_uri": "spotify:track:5QDLhrAOJJdNAmCTJ8xMyW",
        "image_url": "https://cdn.vibelink.com/music/17.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/5QDLhrAOJJdNAmCTJ8xMyW", "external_service": "SPOTIFY",
    },
    {
        "item_id": 18, "item_key": "music_love_dive", "name": "LOVE DIVE",
        "artists": ["IVE"], "album_name": "LOVE DIVE",
        "genres": ["K-Pop", "댄스"], "spotify_uri": "spotify:track:0LBFI6ATm1Aw1iEEJJx1Fj",
        "image_url": "https://cdn.vibelink.com/music/18.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/0LBFI6ATm1Aw1iEEJJx1Fj", "external_service": "SPOTIFY",
    },
    {
        "item_id": 19, "item_key": "music_hype_boy", "name": "Hype Boy",
        "artists": ["NewJeans"], "album_name": "NewJeans 1st EP",
        "genres": ["K-Pop", "R&B"], "spotify_uri": "spotify:track:0a4MMyCrzT0En247IhqZbD",
        "image_url": "https://cdn.vibelink.com/music/19.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/0a4MMyCrzT0En247IhqZbD", "external_service": "SPOTIFY",
    },
    {
        "item_id": 20, "item_key": "music_super_shy", "name": "Super Shy",
        "artists": ["NewJeans"], "album_name": "Get Up",
        "genres": ["K-Pop", "팝"], "spotify_uri": "spotify:track:5sdQOyqq2IDhvmx2lHOpwd",
        "image_url": "https://cdn.vibelink.com/music/20.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/5sdQOyqq2IDhvmx2lHOpwd", "external_service": "SPOTIFY",
    },
    {
        "item_id": 21, "item_key": "music_antifragile", "name": "ANTIFRAGILE",
        "artists": ["LE SSERAFIM"], "album_name": "ANTIFRAGILE",
        "genres": ["K-Pop", "힙합"], "spotify_uri": "spotify:track:4IRGrCMWVPhk3m1OIRjPGT",
        "image_url": "https://cdn.vibelink.com/music/21.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/4IRGrCMWVPhk3m1OIRjPGT", "external_service": "SPOTIFY",
    },
    {
        "item_id": 22, "item_key": "music_ditto", "name": "Ditto",
        "artists": ["NewJeans"], "album_name": "Ditto",
        "genres": ["K-Pop", "인디팝"], "spotify_uri": "spotify:track:3r8RuvgbX9s7ammBn07D3W",
        "image_url": "https://cdn.vibelink.com/music/22.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/3r8RuvgbX9s7ammBn07D3W", "external_service": "SPOTIFY",
    },
    {
        "item_id": 23, "item_key": "music_next_level", "name": "Next Level",
        "artists": ["aespa"], "album_name": "Next Level",
        "genres": ["K-Pop", "일렉트로닉"], "spotify_uri": "spotify:track:2zrhoHlFKxFTRF5K1eFNFn",
        "image_url": "https://cdn.vibelink.com/music/23.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/2zrhoHlFKxFTRF5K1eFNFn", "external_service": "SPOTIFY",
    },
    {
        "item_id": 24, "item_key": "music_good_day", "name": "좋은 날",
        "artists": ["IU"], "album_name": "Real",
        "genres": ["K-Pop", "발라드"], "spotify_uri": "spotify:track:4GGf3FRMhSuvNJboj04aBt",
        "image_url": "https://cdn.vibelink.com/music/24.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/4GGf3FRMhSuvNJboj04aBt", "external_service": "SPOTIFY",
    },
    {
        "item_id": 25, "item_key": "music_celebrity", "name": "Celebrity",
        "artists": ["IU"], "album_name": "LILAC",
        "genres": ["K-Pop", "팝"], "spotify_uri": "spotify:track:5nCwjMqSPMCEiMkgmJOHRf",
        "image_url": "https://cdn.vibelink.com/music/25.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/5nCwjMqSPMCEiMkgmJOHRf", "external_service": "SPOTIFY",
    },
    {
        "item_id": 26, "item_key": "music_through_the_night", "name": "밤편지",
        "artists": ["IU"], "album_name": "밤편지",
        "genres": ["K-Pop", "발라드"], "spotify_uri": "spotify:track:3MjUtNVVq3C8Fn0MP3zhXa",
        "image_url": "https://cdn.vibelink.com/music/26.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/3MjUtNVVq3C8Fn0MP3zhXa", "external_service": "SPOTIFY",
    },
    {
        "item_id": 27, "item_key": "music_bohemian_rhapsody", "name": "Bohemian Rhapsody",
        "artists": ["Queen"], "album_name": "A Night at the Opera",
        "genres": ["록", "프로그레시브"], "spotify_uri": "spotify:track:4u7EnebtmKWzUH433cf5Qv",
        "image_url": "https://cdn.vibelink.com/music/27.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/4u7EnebtmKWzUH433cf5Qv", "external_service": "SPOTIFY",
    },
    {
        "item_id": 28, "item_key": "music_blinding_lights", "name": "Blinding Lights",
        "artists": ["The Weeknd"], "album_name": "After Hours",
        "genres": ["팝", "신스팝"], "spotify_uri": "spotify:track:0VjIjW4GlUZAMYd2vXMi3b",
        "image_url": "https://cdn.vibelink.com/music/28.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/0VjIjW4GlUZAMYd2vXMi3b", "external_service": "SPOTIFY",
    },
    {
        "item_id": 29, "item_key": "music_shape_of_you", "name": "Shape of You",
        "artists": ["Ed Sheeran"], "album_name": "Divide",
        "genres": ["팝", "댄스팝"], "spotify_uri": "spotify:track:7qiZfU4dY1lWllzX7mPBI3",
        "image_url": "https://cdn.vibelink.com/music/29.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/7qiZfU4dY1lWllzX7mPBI3", "external_service": "SPOTIFY",
    },
    {
        "item_id": 30, "item_key": "music_hotel_california", "name": "Hotel California",
        "artists": ["Eagles"], "album_name": "Hotel California",
        "genres": ["록", "소프트록"], "spotify_uri": "spotify:track:40riOy7x9W7GXjyGp4pjAv",
        "image_url": "https://cdn.vibelink.com/music/30.jpg",
        "brand": None, "external_link": "https://open.spotify.com/track/40riOy7x9W7GXjyGp4pjAv", "external_service": "SPOTIFY",
    },
]

LIGHTING = [
    {
        "item_id": 31, "item_key": "light_warm_pendant", "name": "웜 펜던트 조명",
        "color_temp_kelvin": 2700, "color_temp_name": "전구색",
        "brightness_percent": 40, "lighting_type": "펜던트",
        "space_context": "거실, 침실", "time_context": "저녁~밤",
        "image_url": "https://cdn.vibelink.com/lighting/31.jpg",
        "brand": "Philips Hue", "external_link": None, "external_service": "HUE",
    },
    {
        "item_id": 32, "item_key": "light_sunset_indirect", "name": "선셋 간접 조명",
        "color_temp_kelvin": 2200, "color_temp_name": "촛불색",
        "brightness_percent": 30, "lighting_type": "간접조명",
        "space_context": "거실, 서재", "time_context": "오후~저녁",
        "image_url": "https://cdn.vibelink.com/lighting/32.jpg",
        "brand": "Philips Hue", "external_link": None, "external_service": "HUE",
    },
    {
        "item_id": 33, "item_key": "light_candle_warm", "name": "캔들 웜 조명",
        "color_temp_kelvin": 1800, "color_temp_name": "촛불색",
        "brightness_percent": 20, "lighting_type": "캔들",
        "space_context": "침실, 레스토랑", "time_context": "밤",
        "image_url": "https://cdn.vibelink.com/lighting/33.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 34, "item_key": "light_moonlight_blue", "name": "문라이트 블루 조명",
        "color_temp_kelvin": 6500, "color_temp_name": "주광색",
        "brightness_percent": 25, "lighting_type": "간접조명",
        "space_context": "침실", "time_context": "밤~새벽",
        "image_url": "https://cdn.vibelink.com/lighting/34.jpg",
        "brand": "Philips Hue", "external_link": None, "external_service": "HUE",
    },
    {
        "item_id": 35, "item_key": "light_daylight_natural", "name": "데이라이트 자연광",
        "color_temp_kelvin": 5000, "color_temp_name": "자연광",
        "brightness_percent": 80, "lighting_type": "LED패널",
        "space_context": "서재, 사무실", "time_context": "오전~오후",
        "image_url": "https://cdn.vibelink.com/lighting/35.jpg",
        "brand": "IKEA", "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 36, "item_key": "light_reading_desk", "name": "독서 데스크램프",
        "color_temp_kelvin": 3500, "color_temp_name": "주백색",
        "brightness_percent": 60, "lighting_type": "데스크램프",
        "space_context": "서재", "time_context": "저녁",
        "image_url": "https://cdn.vibelink.com/lighting/36.jpg",
        "brand": "IKEA", "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 37, "item_key": "light_party_rgb", "name": "파티 RGB 조명",
        "color_temp_kelvin": 0, "color_temp_name": "멀티컬러",
        "brightness_percent": 90, "lighting_type": "LED스트립",
        "space_context": "거실, 파티룸", "time_context": "밤",
        "image_url": "https://cdn.vibelink.com/lighting/37.jpg",
        "brand": "Philips Hue", "external_link": None, "external_service": "HUE",
    },
    {
        "item_id": 38, "item_key": "light_aurora_dynamic", "name": "오로라 다이나믹 조명",
        "color_temp_kelvin": 0, "color_temp_name": "멀티컬러",
        "brightness_percent": 50, "lighting_type": "프로젝터",
        "space_context": "침실", "time_context": "밤",
        "image_url": "https://cdn.vibelink.com/lighting/38.jpg",
        "brand": "Philips Hue", "external_link": None, "external_service": "HUE",
    },
    {
        "item_id": 39, "item_key": "light_cafe_ambient", "name": "카페 앰비언트 조명",
        "color_temp_kelvin": 2700, "color_temp_name": "전구색",
        "brightness_percent": 35, "lighting_type": "펜던트",
        "space_context": "카페, 거실", "time_context": "오후~저녁",
        "image_url": "https://cdn.vibelink.com/lighting/39.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 40, "item_key": "light_studio_bright", "name": "스튜디오 브라이트",
        "color_temp_kelvin": 5500, "color_temp_name": "주광색",
        "brightness_percent": 95, "lighting_type": "LED패널",
        "space_context": "작업실, 사무실", "time_context": "오전~오후",
        "image_url": "https://cdn.vibelink.com/lighting/40.jpg",
        "brand": "IKEA", "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 41, "item_key": "light_romantic_pink", "name": "로맨틱 핑크 조명",
        "color_temp_kelvin": 3000, "color_temp_name": "전구색",
        "brightness_percent": 30, "lighting_type": "간접조명",
        "space_context": "침실", "time_context": "저녁~밤",
        "image_url": "https://cdn.vibelink.com/lighting/41.jpg",
        "brand": "Philips Hue", "external_link": None, "external_service": "HUE",
    },
    {
        "item_id": 42, "item_key": "light_forest_green", "name": "포레스트 그린 조명",
        "color_temp_kelvin": 4000, "color_temp_name": "주백색",
        "brightness_percent": 45, "lighting_type": "LED스트립",
        "space_context": "거실, 발코니", "time_context": "오후",
        "image_url": "https://cdn.vibelink.com/lighting/42.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
    {
        "item_id": 43, "item_key": "light_ocean_wave", "name": "오션 웨이브 조명",
        "color_temp_kelvin": 0, "color_temp_name": "멀티컬러",
        "brightness_percent": 40, "lighting_type": "프로젝터",
        "space_context": "침실, 욕실", "time_context": "밤",
        "image_url": "https://cdn.vibelink.com/lighting/43.jpg",
        "brand": "Philips Hue", "external_link": None, "external_service": "HUE",
    },
    {
        "item_id": 44, "item_key": "light_sunrise_gradient", "name": "선라이즈 그라디언트",
        "color_temp_kelvin": 3000, "color_temp_name": "전구색",
        "brightness_percent": 70, "lighting_type": "간접조명",
        "space_context": "침실", "time_context": "새벽~아침",
        "image_url": "https://cdn.vibelink.com/lighting/44.jpg",
        "brand": "Philips Hue", "external_link": None, "external_service": "HUE",
    },
    {
        "item_id": 45, "item_key": "light_fireplace_flicker", "name": "벽난로 플리커 조명",
        "color_temp_kelvin": 2000, "color_temp_name": "촛불색",
        "brightness_percent": 25, "lighting_type": "LED캔들",
        "space_context": "거실", "time_context": "저녁~밤",
        "image_url": "https://cdn.vibelink.com/lighting/45.jpg",
        "brand": None, "external_link": None, "external_service": "OTHER",
    },
]

COFFEE = [
    {
        "item_id": 46, "item_key": "coffee_melozio", "name": "멜로지오",
        "capsule_name": "멜로지오", "intensity": 6, "roast_level": "MEDIUM",
        "flavor_notes": "부드럽고 달콤한 꿀과 비스킷 풍미",
        "aroma_profile": ["꿀", "비스킷"], "body": 3, "acidity": 2,
        "image_url": "https://cdn.vibelink.com/coffee/46.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/melozio", "external_service": "NESPRESSO",
    },
    {
        "item_id": 47, "item_key": "coffee_napoli", "name": "나폴리",
        "capsule_name": "나폴리", "intensity": 13, "roast_level": "DARK",
        "flavor_notes": "강렬하고 스파이시한 나폴리 전통 에스프레소",
        "aroma_profile": ["스파이시", "우디"], "body": 5, "acidity": 1,
        "image_url": "https://cdn.vibelink.com/coffee/47.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/napoli", "external_service": "NESPRESSO",
    },
    {
        "item_id": 48, "item_key": "coffee_roma", "name": "로마",
        "capsule_name": "로마", "intensity": 8, "roast_level": "MEDIUM",
        "flavor_notes": "우아한 견과류 향과 우디 노트",
        "aroma_profile": ["견과류", "우디"], "body": 4, "acidity": 2,
        "image_url": "https://cdn.vibelink.com/coffee/48.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/roma", "external_service": "NESPRESSO",
    },
    {
        "item_id": 49, "item_key": "coffee_ristretto", "name": "리스트레토",
        "capsule_name": "리스트레토", "intensity": 10, "roast_level": "MEDIUM",
        "flavor_notes": "풍부하고 과일향 가득한 리스트레토",
        "aroma_profile": ["과일", "시트러스"], "body": 4, "acidity": 3,
        "image_url": "https://cdn.vibelink.com/coffee/49.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/ristretto", "external_service": "NESPRESSO",
    },
    {
        "item_id": 50, "item_key": "coffee_arpeggio", "name": "아르페지오",
        "capsule_name": "아르페지오", "intensity": 9, "roast_level": "DARK",
        "flavor_notes": "진한 코코아 풍미의 크리미한 에스프레소",
        "aroma_profile": ["코코아", "구운빵"], "body": 4, "acidity": 2,
        "image_url": "https://cdn.vibelink.com/coffee/50.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/arpeggio", "external_service": "NESPRESSO",
    },
    {
        "item_id": 51, "item_key": "coffee_livanto", "name": "리반토",
        "capsule_name": "리반토", "intensity": 6, "roast_level": "MEDIUM",
        "flavor_notes": "균형 잡힌 캐러멜 풍미의 에스프레소",
        "aroma_profile": ["캐러멜", "곡물"], "body": 3, "acidity": 2,
        "image_url": "https://cdn.vibelink.com/coffee/51.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/livanto", "external_service": "NESPRESSO",
    },
    {
        "item_id": 52, "item_key": "coffee_capriccio", "name": "카프리치오",
        "capsule_name": "카프리치오", "intensity": 5, "roast_level": "MEDIUM",
        "flavor_notes": "가벼운 곡물향의 밸런스 좋은 에스프레소",
        "aroma_profile": ["곡물", "견과류"], "body": 3, "acidity": 2,
        "image_url": "https://cdn.vibelink.com/coffee/52.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/capriccio", "external_service": "NESPRESSO",
    },
    {
        "item_id": 53, "item_key": "coffee_volluto", "name": "볼루토",
        "capsule_name": "볼루토", "intensity": 4, "roast_level": "MEDIUM",
        "flavor_notes": "달콤한 비스킷과 과일 노트의 라이트 에스프레소",
        "aroma_profile": ["비스킷", "과일"], "body": 2, "acidity": 2,
        "image_url": "https://cdn.vibelink.com/coffee/53.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/volluto", "external_service": "NESPRESSO",
    },
    {
        "item_id": 54, "item_key": "coffee_cosi", "name": "코시",
        "capsule_name": "코시", "intensity": 3, "roast_level": "MEDIUM",
        "flavor_notes": "상쾌한 시트러스향의 라이트 에스프레소",
        "aroma_profile": ["시트러스", "곡물"], "body": 2, "acidity": 3,
        "image_url": "https://cdn.vibelink.com/coffee/54.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/cosi", "external_service": "NESPRESSO",
    },
    {
        "item_id": 55, "item_key": "coffee_kazaar", "name": "카자르",
        "capsule_name": "카자르", "intensity": 12, "roast_level": "DARK",
        "flavor_notes": "대담하고 강렬한 후추 풍미의 에스프레소",
        "aroma_profile": ["후추", "우디", "견과류"], "body": 5, "acidity": 1,
        "image_url": "https://cdn.vibelink.com/coffee/55.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/kazaar", "external_service": "NESPRESSO",
    },
    {
        "item_id": 56, "item_key": "coffee_dharkan", "name": "다칸",
        "capsule_name": "다칸", "intensity": 11, "roast_level": "DARK",
        "flavor_notes": "벨벳 같은 다크 초콜릿과 아몬드 풍미",
        "aroma_profile": ["초콜릿", "아몬드"], "body": 5, "acidity": 1,
        "image_url": "https://cdn.vibelink.com/coffee/56.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/dharkan", "external_service": "NESPRESSO",
    },
    {
        "item_id": 57, "item_key": "coffee_stormio", "name": "스토르미오",
        "capsule_name": "스토르미오", "intensity": 8, "roast_level": "DARK",
        "flavor_notes": "우디하고 스모키한 풀바디 머그 커피",
        "aroma_profile": ["우디", "스모키"], "body": 4, "acidity": 1,
        "image_url": "https://cdn.vibelink.com/coffee/57.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/stormio", "external_service": "NESPRESSO",
    },
    {
        "item_id": 58, "item_key": "coffee_odacio", "name": "오다시오",
        "capsule_name": "오다시오", "intensity": 5, "roast_level": "MEDIUM",
        "flavor_notes": "깔끔한 곡물향과 과일 노트의 머그 커피",
        "aroma_profile": ["곡물", "과일"], "body": 3, "acidity": 3,
        "image_url": "https://cdn.vibelink.com/coffee/58.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/odacio", "external_service": "NESPRESSO",
    },
    {
        "item_id": 59, "item_key": "coffee_giornio", "name": "지오르니오",
        "capsule_name": "지오르니오", "intensity": 4, "roast_level": "MEDIUM",
        "flavor_notes": "섬세한 꽃향과 곡물의 조화로운 머그 커피",
        "aroma_profile": ["꽃", "곡물"], "body": 2, "acidity": 2,
        "image_url": "https://cdn.vibelink.com/coffee/59.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/giornio", "external_service": "NESPRESSO",
    },
    {
        "item_id": 60, "item_key": "coffee_altissio", "name": "알티시오",
        "capsule_name": "알티시오", "intensity": 9, "roast_level": "DARK",
        "flavor_notes": "크리미하고 캐러멜 풍미의 버투오 에스프레소",
        "aroma_profile": ["캐러멜", "크리미"], "body": 4, "acidity": 2,
        "image_url": "https://cdn.vibelink.com/coffee/60.jpg",
        "brand": "Nespresso", "external_link": "https://www.nespresso.com/kr/ko/altissio", "external_service": "NESPRESSO",
    },
]


# ============================================================
# Seed Functions
# ============================================================

async def seed_options() -> int:
    """옵션 노드 (Mood, Time, Weather, Place, Companion) 생성"""
    batch: list[tuple[str, dict]] = []

    for m in MOODS:
        batch.append((queries.UPSERT_MOOD, m))
    for t in TIMES:
        batch.append((queries.UPSERT_TIME, t))
    for w in WEATHERS:
        batch.append((queries.UPSERT_WEATHER, w))
    for p in PLACES:
        batch.append((queries.UPSERT_PLACE, p))
    for c in COMPANIONS:
        batch.append((queries.UPSERT_COMPANION, c))
    for cat in CATEGORIES:
        batch.append((queries.UPSERT_CATEGORY, cat))

    await execute_write_batch(batch)
    count = len(batch)
    print(f"  옵션 노드 {count}개 생성 완료")
    return count


async def seed_movies() -> tuple[int, int]:
    """영화 노드 + HAS_GENRE 관계 생성"""
    node_count = 0
    rel_count = 0
    for movie in MOVIES:
        params = {
            "item_id": movie["item_id"],
            "item_key": movie["item_key"],
            "name": movie["name"],
            "tmdb_id": movie["tmdb_id"],
            "genres": movie["genres"],
            "keywords": movie["keywords"],
            "vote_average": movie["vote_average"],
            "runtime": movie["runtime"],
            "overview": movie["overview"],
            "image_url": movie["image_url"],
            "brand": movie["brand"],
            "external_link": movie["external_link"],
            "external_service": movie["external_service"],
        }
        await execute_write(queries.UPSERT_MOVIE, params)
        node_count += 1

        for genre in movie["genres"]:
            await execute_write(queries.CREATE_HAS_GENRE, {"item_id": movie["item_id"], "genre_name": genre})
            rel_count += 1

    print(f"  영화 노드 {node_count}개, HAS_GENRE 관계 {rel_count}개 생성")
    return node_count, rel_count


async def seed_music() -> tuple[int, int]:
    """음악 노드 + HAS_GENRE 관계 생성"""
    node_count = 0
    rel_count = 0
    for music in MUSIC:
        params = {
            "item_id": music["item_id"],
            "item_key": music["item_key"],
            "name": music["name"],
            "artists": music["artists"],
            "album_name": music["album_name"],
            "genres": music["genres"],
            "spotify_uri": music["spotify_uri"],
            "image_url": music["image_url"],
            "brand": music["brand"],
            "external_link": music["external_link"],
            "external_service": music["external_service"],
        }
        await execute_write(queries.UPSERT_MUSIC, params)
        node_count += 1

        for genre in music["genres"]:
            await execute_write(queries.CREATE_HAS_GENRE, {"item_id": music["item_id"], "genre_name": genre})
            rel_count += 1

    print(f"  음악 노드 {node_count}개, HAS_GENRE 관계 {rel_count}개 생성")
    return node_count, rel_count


async def seed_lighting() -> tuple[int, int]:
    """조명 노드 생성"""
    node_count = 0
    for light in LIGHTING:
        params = {
            "item_id": light["item_id"],
            "item_key": light["item_key"],
            "name": light["name"],
            "color_temp_kelvin": light["color_temp_kelvin"],
            "color_temp_name": light["color_temp_name"],
            "brightness_percent": light["brightness_percent"],
            "lighting_type": light["lighting_type"],
            "space_context": light["space_context"],
            "time_context": light["time_context"],
            "image_url": light["image_url"],
            "brand": light["brand"],
            "external_link": light["external_link"],
            "external_service": light["external_service"],
        }
        await execute_write(queries.UPSERT_LIGHTING, params)
        node_count += 1

    print(f"  조명 노드 {node_count}개 생성")
    return node_count, 0


async def seed_coffee() -> tuple[int, int]:
    """커피 노드 생성"""
    node_count = 0
    for coffee in COFFEE:
        params = {
            "item_id": coffee["item_id"],
            "item_key": coffee["item_key"],
            "name": coffee["name"],
            "capsule_name": coffee["capsule_name"],
            "intensity": coffee["intensity"],
            "roast_level": coffee["roast_level"],
            "flavor_notes": coffee["flavor_notes"],
            "aroma_profile": coffee["aroma_profile"],
            "body": coffee["body"],
            "acidity": coffee["acidity"],
            "image_url": coffee["image_url"],
            "brand": coffee["brand"],
            "external_link": coffee["external_link"],
            "external_service": coffee["external_service"],
        }
        await execute_write(queries.UPSERT_COFFEE, params)
        node_count += 1

    print(f"  커피 노드 {node_count}개 생성")
    return node_count, 0


async def main() -> None:
    parser = argparse.ArgumentParser(description="Neo4j Graph Seed Script")
    parser.add_argument("--with-fits", action="store_true", help="LLM으로 FITS_* 관계 가중치 초기화")
    args = parser.parse_args()

    setup_logging(debug=True)
    print("=== VibeConnector Neo4j Seed Script ===")
    print(f"Neo4j: {settings.neo4j_uri}")
    print()

    await init_driver()
    await apply_schema()

    start = time.time()
    total_nodes = 0
    total_rels = 0

    # 1. 옵션 노드
    print("[1/5] 옵션 노드 생성...")
    total_nodes += await seed_options()

    # 2. 영화
    print("[2/5] 영화 노드 생성...")
    n, r = await seed_movies()
    total_nodes += n
    total_rels += r

    # 3. 음악
    print("[3/5] 음악 노드 생성...")
    n, r = await seed_music()
    total_nodes += n
    total_rels += r

    # 4. 조명
    print("[4/5] 조명 노드 생성...")
    n, r = await seed_lighting()
    total_nodes += n
    total_rels += r

    # 5. 커피
    print("[5/5] 커피 노드 생성...")
    n, r = await seed_coffee()
    total_nodes += n
    total_rels += r

    elapsed = int((time.time() - start) * 1000)
    print()
    print(f"=== 노드 시드 완료 ===")
    print(f"총 노드: {total_nodes}개, 관계: {total_rels}개 ({elapsed}ms)")

    # FITS_* 관계 초기화 (옵션)
    if args.with_fits:
        print()
        print("=== FITS_* 관계 가중치 초기화 (LLM) ===")
        print("60개 아이템 × LLM 평가 중... (약 2-5분 소요)")
        from app.services.weight_init_service import evaluate_and_create_fits
        result = await evaluate_and_create_fits(batch_size=5)
        print(f"완료: {result}")

    await close_driver()


if __name__ == "__main__":
    asyncio.run(main())
