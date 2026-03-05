-- ============================================================
-- Vibe-Link v3.2 Mock Data (PostgreSQL)
-- 생성일: 2026-02-23
-- 총 44개 테이블 / 테이블당 15건 (items는 60건)
-- FK 의존성 순서(Level 0 → 7 → 비MVP)로 배치
-- ============================================================
BEGIN;
-- ============================================================
-- LEVEL 0: Base Tables (FK 의존성 없음) — 7 tables
-- ============================================================
-- [1/44] languages (15건)
INSERT INTO languages (
        language_id,
        language_code,
        is_active,
        created_at
    )
VALUES (1, 'ko', TRUE, '2025-01-01 00:00:00'),
    (2, 'en', TRUE, '2025-01-01 00:00:00'),
    (3, 'ja', TRUE, '2025-01-01 00:00:00'),
    (4, 'zh', TRUE, '2025-01-01 00:00:00'),
    (5, 'es', TRUE, '2025-01-01 00:00:00'),
    (6, 'fr', TRUE, '2025-01-01 00:00:00'),
    (7, 'de', TRUE, '2025-01-01 00:00:00'),
    (8, 'pt', TRUE, '2025-01-01 00:00:00'),
    (9, 'it', TRUE, '2025-01-01 00:00:00'),
    (10, 'ru', TRUE, '2025-01-01 00:00:00'),
    (11, 'ar', TRUE, '2025-01-01 00:00:00'),
    (12, 'hi', TRUE, '2025-01-01 00:00:00'),
    (13, 'vi', TRUE, '2025-01-01 00:00:00'),
    (14, 'th', TRUE, '2025-01-01 00:00:00'),
    (15, 'id', TRUE, '2025-01-01 00:00:00') ON CONFLICT (language_code) DO NOTHING;
-- [2/44] mood_keywords (15건)
INSERT INTO mood_keywords (keyword_id, keyword_value, category, created_at)
VALUES (
        1,
        'cozy',
        '감정',
        '2025-01-01 00:00:00'
    ),
    (
        2,
        'dreamy',
        '분위기',
        '2025-01-01 00:00:00'
    ),
    (
        3,
        'languid',
        '감정',
        '2025-01-01 00:00:00'
    ),
    (
        4,
        'crisp',
        '에너지',
        '2025-01-01 00:00:00'
    ),
    (
        5,
        'melancholic',
        '감정',
        '2025-01-01 00:00:00'
    ),
    (
        6,
        'energetic',
        '에너지',
        '2025-01-01 00:00:00'
    ),
    (
        7,
        'serene',
        '분위기',
        '2025-01-01 00:00:00'
    ),
    (
        8,
        'nostalgic',
        '감정',
        '2025-01-01 00:00:00'
    ),
    (
        9,
        'focused',
        '에너지',
        '2025-01-01 00:00:00'
    ),
    (
        10,
        'whimsical',
        '에너지',
        '2025-01-01 00:00:00'
    ),
    (
        11,
        'romantic',
        '분위기',
        '2025-01-01 00:00:00'
    ),
    (
        12,
        'mysterious',
        '분위기',
        '2025-01-01 00:00:00'
    ),
    (
        13,
        'warm',
        '감정',
        '2025-01-01 00:00:00'
    ),
    (
        14,
        'refreshing',
        '에너지',
        '2025-01-01 00:00:00'
    ),
    (
        15,
        'contemplative',
        '분위기',
        '2025-01-01 00:00:00'
    ) ON CONFLICT (keyword_value) DO NOTHING;
-- [3/44] time_options (15건)
INSERT INTO time_options (time_id, time_key, time_value, period, is_active)
VALUES (1, 'dawn', '04:00:00', 'AM', TRUE),
    (2, 'early_morning', '06:00:00', 'AM', TRUE),
    (3, 'morning', '08:00:00', 'AM', TRUE),
    (4, 'mid_morning', '10:00:00', 'AM', TRUE),
    (5, 'late_morning', '11:00:00', 'AM', TRUE),
    (6, 'noon', '12:00:00', 'PM', TRUE),
    (7, 'early_afternoon', '13:00:00', 'PM', TRUE),
    (8, 'afternoon', '14:30:00', 'PM', TRUE),
    (9, 'mid_afternoon', '16:00:00', 'PM', TRUE),
    (10, 'late_afternoon', '17:30:00', 'PM', TRUE),
    (11, 'evening', '19:00:00', 'PM', TRUE),
    (12, 'night', '21:00:00', 'PM', TRUE),
    (13, 'late_night', '23:00:00', 'PM', TRUE),
    (14, 'midnight', '00:00:00', 'AM', TRUE),
    (15, 'small_hours', '02:00:00', 'AM', TRUE) ON CONFLICT (time_key) DO NOTHING;
-- [4/44] weather_options (15건)
INSERT INTO weather_options (weather_id, weather_key, is_active)
VALUES (1, 'sunny', TRUE),
    (2, 'cloudy', TRUE),
    (3, 'rainy', TRUE),
    (4, 'snowy', TRUE),
    (5, 'windy', TRUE),
    (6, 'foggy', TRUE),
    (7, 'stormy', TRUE),
    (8, 'drizzle', TRUE),
    (9, 'humid', TRUE),
    (10, 'dry', TRUE),
    (11, 'chilly', TRUE),
    (12, 'hot', TRUE),
    (13, 'mild', TRUE),
    (14, 'hazy', TRUE),
    (15, 'thunderstorm', TRUE) ON CONFLICT (weather_key) DO NOTHING;
-- [5/44] place_options (15건)
INSERT INTO place_options (place_id, place_key, is_active)
VALUES (1, 'home', TRUE),
    (2, 'cafe', TRUE),
    (3, 'office', TRUE),
    (4, 'park', TRUE),
    (5, 'beach', TRUE),
    (6, 'mountain', TRUE),
    (7, 'library', TRUE),
    (8, 'restaurant', TRUE),
    (9, 'bar', TRUE),
    (10, 'studio', TRUE),
    (11, 'bedroom', TRUE),
    (12, 'rooftop', TRUE),
    (13, 'car', TRUE),
    (14, 'train', TRUE),
    (15, 'bookstore', TRUE) ON CONFLICT (place_key) DO NOTHING;
-- [6/44] companion_options (15건)
INSERT INTO companion_options (companion_id, companion_key, is_active)
VALUES (1, 'alone', TRUE),
    (2, 'partner', TRUE),
    (3, 'friends', TRUE),
    (4, 'family', TRUE),
    (5, 'pet', TRUE),
    (6, 'colleagues', TRUE),
    (7, 'child', TRUE),
    (8, 'parents', TRUE),
    (9, 'sibling', TRUE),
    (10, 'best_friend', TRUE),
    (11, 'stranger', TRUE),
    (12, 'mentor', TRUE),
    (13, 'group', TRUE),
    (14, 'date', TRUE),
    (15, 'classmates', TRUE) ON CONFLICT (companion_key) DO NOTHING;
-- [7/44] item_categories (15건)
INSERT INTO item_categories (
        category_id,
        category_key,
        sense_type,
        is_active,
        created_at
    )
VALUES (
        1,
        'video',
        '["VISUAL","AUDITORY"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        2,
        'music',
        '["AUDITORY"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        3,
        'lighting',
        '["VISUAL"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        4,
        'coffee',
        '["GUSTATORY","OLFACTORY"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        5,
        'book',
        '["VISUAL"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        6,
        'food',
        '["GUSTATORY","OLFACTORY"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        7,
        'drink',
        '["GUSTATORY"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        8,
        'fashion',
        '["VISUAL","TACTILE"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        9,
        'fragrance',
        '["OLFACTORY"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        10,
        'plant',
        '["VISUAL","OLFACTORY"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        11,
        'game',
        '["VISUAL","AUDITORY"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        12,
        'art',
        '["VISUAL"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        13,
        'travel',
        '["VISUAL"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        14,
        'wellness',
        '["TACTILE"]',
        TRUE,
        '2025-01-01 00:00:00'
    ),
    (
        15,
        'tech',
        '["VISUAL","TACTILE"]',
        TRUE,
        '2025-01-01 00:00:00'
    ) ON CONFLICT (category_key) DO NOTHING;
-- ============================================================
-- LEVEL 1: References Level 0 — 7 tables
-- ============================================================
-- [8/44] users (15건)
INSERT INTO users (
        user_id,
        email,
        password,
        name,
        nickname,
        gender,
        birth_year,
        profile_image_url,
        preferred_language_id,
        status,
        last_login_at,
        created_at,
        updated_at,
        deleted_at
    )
VALUES (
        1,
        'minjun.kim@example.com',
        '$2a$10$dummyhash1234567890abc',
        '김민준',
        '민준이',
        'MALE',
        1995,
        'https://cdn.vibelink.com/profiles/1.jpg',
        1,
        'ACTIVE',
        '2025-12-01 09:30:00',
        '2025-06-01 10:00:00',
        '2025-12-01 09:30:00',
        NULL
    ),
    (
        2,
        'seoyeon.lee@example.com',
        '$2a$10$dummyhash1234567890def',
        '이서연',
        '서연느',
        'FEMALE',
        1998,
        'https://cdn.vibelink.com/profiles/2.jpg',
        1,
        'ACTIVE',
        '2025-12-02 14:20:00',
        '2025-06-05 11:00:00',
        '2025-12-02 14:20:00',
        NULL
    ),
    (
        3,
        'jiho.park@example.com',
        '$2a$10$dummyhash1234567890ghi',
        '박지호',
        '지호파크',
        'MALE',
        1992,
        'https://cdn.vibelink.com/profiles/3.jpg',
        1,
        'ACTIVE',
        '2025-12-03 18:45:00',
        '2025-06-10 09:00:00',
        '2025-12-03 18:45:00',
        NULL
    ),
    (
        4,
        'sua.choi@example.com',
        '$2a$10$dummyhash1234567890jkl',
        '최수아',
        '수아',
        'FEMALE',
        2000,
        'https://cdn.vibelink.com/profiles/4.jpg',
        1,
        'ACTIVE',
        '2025-12-01 22:10:00',
        '2025-07-01 15:00:00',
        '2025-12-01 22:10:00',
        NULL
    ),
    (
        5,
        'doyun.jung@example.com',
        '$2a$10$dummyhash1234567890mno',
        '정도윤',
        '도윤정',
        'MALE',
        1997,
        'https://cdn.vibelink.com/profiles/5.jpg',
        2,
        'ACTIVE',
        '2025-11-28 11:00:00',
        '2025-07-15 08:00:00',
        '2025-11-28 11:00:00',
        NULL
    ),
    (
        6,
        'yerin.han@example.com',
        '$2a$10$dummyhash1234567890pqr',
        '한예린',
        '예린한',
        'FEMALE',
        1996,
        'https://cdn.vibelink.com/profiles/6.jpg',
        1,
        'ACTIVE',
        '2025-12-04 07:30:00',
        '2025-07-20 12:00:00',
        '2025-12-04 07:30:00',
        NULL
    ),
    (
        7,
        'hajun.kang@example.com',
        '$2a$10$dummyhash1234567890stu',
        '강하준',
        '하준강',
        'MALE',
        1993,
        'https://cdn.vibelink.com/profiles/7.jpg',
        3,
        'ACTIVE',
        '2025-12-02 20:00:00',
        '2025-08-01 10:00:00',
        '2025-12-02 20:00:00',
        NULL
    ),
    (
        8,
        'jieun.yoon@example.com',
        '$2a$10$dummyhash1234567890vwx',
        '윤지은',
        '지은윤',
        'FEMALE',
        1999,
        'https://cdn.vibelink.com/profiles/8.jpg',
        1,
        'ACTIVE',
        '2025-12-05 16:15:00',
        '2025-08-10 14:00:00',
        '2025-12-05 16:15:00',
        NULL
    ),
    (
        9,
        'taehyun.lim@example.com',
        '$2a$10$dummyhash1234567890yza',
        '임태현',
        '태현',
        'MALE',
        1994,
        'https://cdn.vibelink.com/profiles/9.jpg',
        1,
        'ACTIVE',
        '2025-11-30 13:40:00',
        '2025-08-20 09:00:00',
        '2025-11-30 13:40:00',
        NULL
    ),
    (
        10,
        'subin.oh@example.com',
        '$2a$10$dummyhash1234567890bcd',
        '오수빈',
        '수빈오',
        'FEMALE',
        2001,
        'https://cdn.vibelink.com/profiles/10.jpg',
        1,
        'ACTIVE',
        '2025-12-03 10:00:00',
        '2025-09-01 11:00:00',
        '2025-12-03 10:00:00',
        NULL
    ),
    (
        11,
        'junwoo.seo@example.com',
        '$2a$10$dummyhash1234567890efg',
        '서준우',
        '준우서',
        'MALE',
        1991,
        'https://cdn.vibelink.com/profiles/11.jpg',
        2,
        'ACTIVE',
        '2025-11-25 08:20:00',
        '2025-09-10 16:00:00',
        '2025-11-25 08:20:00',
        NULL
    ),
    (
        12,
        'haeun.shin@example.com',
        '$2a$10$dummyhash1234567890hij',
        '신하은',
        '하은신',
        'FEMALE',
        1997,
        'https://cdn.vibelink.com/profiles/12.jpg',
        1,
        'INACTIVE',
        '2025-10-15 12:00:00',
        '2025-09-15 13:00:00',
        '2025-10-15 12:00:00',
        NULL
    ),
    (
        13,
        'minseo.song@example.com',
        '$2a$10$dummyhash1234567890klm',
        '송민서',
        '민서쏭',
        'FEMALE',
        2002,
        'https://cdn.vibelink.com/profiles/13.jpg',
        1,
        'ACTIVE',
        '2025-12-04 21:30:00',
        '2025-10-01 10:00:00',
        '2025-12-04 21:30:00',
        NULL
    ),
    (
        14,
        'chaewon.yu@example.com',
        '$2a$10$dummyhash1234567890nop',
        '유채원',
        '채원유',
        'FEMALE',
        1998,
        'https://cdn.vibelink.com/profiles/14.jpg',
        4,
        'ACTIVE',
        '2025-12-01 15:45:00',
        '2025-10-10 08:00:00',
        '2025-12-01 15:45:00',
        NULL
    ),
    (
        15,
        'eunho.jo@example.com',
        '$2a$10$dummyhash1234567890qrs',
        '조은호',
        '은호조',
        'MALE',
        1990,
        'https://cdn.vibelink.com/profiles/15.jpg',
        1,
        'SUSPENDED',
        '2025-11-01 10:00:00',
        '2025-10-20 14:00:00',
        '2025-11-01 10:00:00',
        NULL
    ) ON CONFLICT (email) DO NOTHING;
-- [9/44] mood_keyword_translations (15건: 한국어 10 + 영어 5)
INSERT INTO mood_keyword_translations (
        translation_id,
        keyword_id,
        language_id,
        keyword_value,
        description
    )
VALUES (1, 1, 1, '포근한', '따뜻하고 아늑한 느낌'),
    (2, 2, 1, '몽글몽글한', '구름처럼 부드럽고 달콤한 느낌'),
    (3, 3, 1, '나른한', '해가 비치는 오후의 느긋함'),
    (4, 4, 1, '청량한', '상쾌하고 시원한 느낌'),
    (5, 5, 1, '쓸쓸한', '고독하고 적적한 감정'),
    (6, 6, 1, '활기찬', '에너지가 넘치는 상태'),
    (7, 7, 1, '고요한', '평화롭고 조용한 분위기'),
    (8, 8, 1, '향수 어린', '과거에 대한 그리움'),
    (9, 9, 1, '몰입되는', '깊이 집중하는 상태'),
    (10, 10, 1, '발랄한', '가볍고 밝은 에너지'),
    (
        11,
        1,
        2,
        'Cozy',
        'Warm and snug feeling'
    ),
    (
        12,
        2,
        2,
        'Dreamy',
        'Soft and sweet like clouds'
    ),
    (
        13,
        3,
        2,
        'Languid',
        'Relaxed and lazy afternoon feeling'
    ),
    (
        14,
        4,
        2,
        'Crisp',
        'Fresh and cool sensation'
    ),
    (
        15,
        5,
        2,
        'Melancholic',
        'Feeling of loneliness and solitude'
    ),
    (16, 11, 1, '로맨틱한', '사랑스럽고 낭만적인 분위기'),
    (17, 12, 1, '신비로운', '알 수 없는 매혹적인 느낌'),
    (18, 13, 1, '따뜻한', '마음이 편안하고 온기 있는'),
    (19, 14, 1, '상쾌한', '가볍고 시원한 에너지'),
    (20, 15, 1, '사색적인', '깊이 생각에 잠기는 분위기') ON CONFLICT (keyword_id, language_id) DO NOTHING;
-- [10/44] weather_option_translations (15건: 한국어 10 + 영어 5)
INSERT INTO weather_option_translations (
        translation_id,
        weather_id,
        language_id,
        weather_value
    )
VALUES (1, 1, 1, '맑음'),
    (2, 2, 1, '흐림'),
    (3, 3, 1, '비'),
    (4, 4, 1, '눈'),
    (5, 5, 1, '바람'),
    (6, 6, 1, '안개'),
    (7, 7, 1, '폭풍'),
    (8, 8, 1, '이슬비'),
    (9, 9, 1, '습함'),
    (10, 10, 1, '건조'),
    (11, 1, 2, 'Sunny'),
    (12, 2, 2, 'Cloudy'),
    (13, 3, 2, 'Rainy'),
    (14, 4, 2, 'Snowy'),
    (15, 5, 2, 'Windy') ON CONFLICT (weather_id, language_id) DO NOTHING;
-- [11/44] place_option_translations (15건: 한국어 10 + 영어 5)
INSERT INTO place_option_translations (
        translation_id,
        place_id,
        language_id,
        place_value
    )
VALUES (1, 1, 1, '집'),
    (2, 2, 1, '카페'),
    (3, 3, 1, '사무실'),
    (4, 4, 1, '공원'),
    (5, 5, 1, '해변'),
    (6, 6, 1, '산'),
    (7, 7, 1, '도서관'),
    (8, 8, 1, '레스토랑'),
    (9, 9, 1, '바'),
    (10, 10, 1, '작업실'),
    (11, 1, 2, 'Home'),
    (12, 2, 2, 'Cafe'),
    (13, 3, 2, 'Office'),
    (14, 4, 2, 'Park'),
    (15, 5, 2, 'Beach') ON CONFLICT (place_id, language_id) DO NOTHING;
-- [12/44] companion_option_translations (15건: 한국어 10 + 영어 5)
INSERT INTO companion_option_translations (
        translation_id,
        companion_id,
        language_id,
        companion_value
    )
VALUES (1, 1, 1, '혼자'),
    (2, 2, 1, '연인과'),
    (3, 3, 1, '친구들과'),
    (4, 4, 1, '가족과'),
    (5, 5, 1, '반려동물과'),
    (6, 6, 1, '동료와'),
    (7, 7, 1, '아이와'),
    (8, 8, 1, '부모님과'),
    (9, 9, 1, '형제자매와'),
    (10, 10, 1, '절친과'),
    (11, 1, 2, 'Alone'),
    (12, 2, 2, 'With partner'),
    (13, 3, 2, 'With friends'),
    (14, 4, 2, 'With family'),
    (15, 5, 2, 'With pet') ON CONFLICT (companion_id, language_id) DO NOTHING;
-- [13/44] item_category_translations (15건: 한국어 10 + 영어 5)
INSERT INTO item_category_translations (
        translation_id,
        category_id,
        language_id,
        category_value,
        description
    )
VALUES (1, 1, 1, '영상', '영화, 드라마 등 영상 콘텐츠'),
    (2, 2, 1, '음악', '음악 트랙 및 앨범'),
    (3, 3, 1, '조명', '무드 조명 및 조합'),
    (4, 4, 1, '커피', '캡슐 커피 및 원두'),
    (5, 5, 1, '도서', '책 및 전자책'),
    (6, 6, 1, '음식', '푸드 및 레시피'),
    (7, 7, 1, '음료', '차, 주스 등 음료'),
    (8, 8, 1, '패션', '의류 및 액세서리'),
    (9, 9, 1, '향수', '퍼퓸 및 디퓨저'),
    (10, 10, 1, '식물', '화분 및 플랜테리어'),
    (
        11,
        1,
        2,
        'Video',
        'Movies, dramas and video content'
    ),
    (12, 2, 2, 'Music', 'Music tracks and albums'),
    (
        13,
        3,
        2,
        'Lighting',
        'Mood lighting and combinations'
    ),
    (
        14,
        4,
        2,
        'Coffee',
        'Capsule coffee and beans'
    ),
    (15, 5, 2, 'Book', 'Books and e-books') ON CONFLICT (category_id, language_id) DO NOTHING;
-- [14/44] items (60건: 영화15 + 음악15 + 조명15 + 커피15)
INSERT INTO items (
        item_id,
        category_id,
        item_key,
        brand,
        image_url,
        external_link,
        external_service,
        is_active,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES -- 영화 (category_id=1, items 1-15)
    (
        1,
        1,
        'movie_tmdb_496243',
        NULL,
        'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
        'https://www.netflix.com/title/81257639',
        'NETFLIX',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        2,
        1,
        'movie_tmdb_670',
        NULL,
        'https://image.tmdb.org/t/p/w500/uUwMwJzFmPDFmcGJfFGEq7MbX0n.jpg',
        'https://watcha.com/contents/m1234',
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        3,
        1,
        'movie_tmdb_396535',
        NULL,
        'https://image.tmdb.org/t/p/w500/kFCjfRvMCFkYBQoIONOBwbQmMP3.jpg',
        'https://www.netflix.com/title/80108983',
        'NETFLIX',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        4,
        1,
        'movie_tmdb_615643',
        NULL,
        'https://image.tmdb.org/t/p/w500/7RyBmEpegJDjOEGOUkNPpC5HBIL.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        5,
        1,
        'movie_tmdb_906221',
        NULL,
        'https://image.tmdb.org/t/p/w500/tRF6Mhh0I6jr7VpNzH9GJRzIfPU.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        6,
        1,
        'movie_tmdb_157336',
        NULL,
        'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
        'https://www.netflix.com/title/70305903',
        'NETFLIX',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        7,
        1,
        'movie_tmdb_313369',
        NULL,
        'https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        8,
        1,
        'movie_tmdb_27205',
        NULL,
        'https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
        'https://www.netflix.com/title/70131314',
        'NETFLIX',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        9,
        1,
        'movie_tmdb_19995',
        NULL,
        'https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki98lbIIv.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        10,
        1,
        'movie_tmdb_603',
        NULL,
        'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        11,
        1,
        'movie_tmdb_1072790',
        NULL,
        'https://image.tmdb.org/t/p/w500/sKqBiGaIPTp0s2LOz0yzW3BJNQT.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        12,
        1,
        'movie_tmdb_1115396',
        NULL,
        'https://image.tmdb.org/t/p/w500/placeholder12.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        13,
        1,
        'movie_tmdb_1116173',
        NULL,
        'https://image.tmdb.org/t/p/w500/placeholder13.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        14,
        1,
        'movie_tmdb_1815',
        NULL,
        'https://image.tmdb.org/t/p/w500/placeholder14.jpg',
        'https://www.netflix.com/title/70076013',
        'NETFLIX',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        15,
        1,
        'movie_tmdb_442168',
        NULL,
        'https://image.tmdb.org/t/p/w500/placeholder15.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    -- 음악 (category_id=2, items 16-30)
    (
        16,
        2,
        'music_spring_day',
        NULL,
        'https://cdn.vibelink.com/music/16.jpg',
        'https://open.spotify.com/track/0xqiGOyDpB1JMa0on01dEr',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        17,
        2,
        'music_dynamite',
        NULL,
        'https://cdn.vibelink.com/music/17.jpg',
        'https://open.spotify.com/track/5QDLhrAOJJdNAmCTJ8xMyW',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        18,
        2,
        'music_love_dive',
        NULL,
        'https://cdn.vibelink.com/music/18.jpg',
        'https://open.spotify.com/track/0LBFI6ATm1Aw1iEEJJx1Fj',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        19,
        2,
        'music_hype_boy',
        NULL,
        'https://cdn.vibelink.com/music/19.jpg',
        'https://open.spotify.com/track/0a4MMyCrzT0En247IhqZbD',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        20,
        2,
        'music_super_shy',
        NULL,
        'https://cdn.vibelink.com/music/20.jpg',
        'https://open.spotify.com/track/5sdQOyqq2IDhvmx2lHOpwd',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        21,
        2,
        'music_antifragile',
        NULL,
        'https://cdn.vibelink.com/music/21.jpg',
        'https://open.spotify.com/track/4IRGrCMWVPhk3m1OIRjPGT',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        22,
        2,
        'music_ditto',
        NULL,
        'https://cdn.vibelink.com/music/22.jpg',
        'https://open.spotify.com/track/3r8RuvgbX9s7ammBn07D3W',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        23,
        2,
        'music_next_level',
        NULL,
        'https://cdn.vibelink.com/music/23.jpg',
        'https://open.spotify.com/track/2zrhoHlFKxFTRF5K1eFNFn',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        24,
        2,
        'music_good_day',
        NULL,
        'https://cdn.vibelink.com/music/24.jpg',
        'https://open.spotify.com/track/4GGf3FRMhSuvNJboj04aBt',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        25,
        2,
        'music_celebrity',
        NULL,
        'https://cdn.vibelink.com/music/25.jpg',
        'https://open.spotify.com/track/5nCwjMqSPMCEiMkgmJOHRf',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        26,
        2,
        'music_through_the_night',
        NULL,
        'https://cdn.vibelink.com/music/26.jpg',
        'https://open.spotify.com/track/3MjUtNVVq3C8Fn0MP3zhXa',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        27,
        2,
        'music_bohemian_rhapsody',
        NULL,
        'https://cdn.vibelink.com/music/27.jpg',
        'https://open.spotify.com/track/4u7EnebtmKWzUH433cf5Qv',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        28,
        2,
        'music_blinding_lights',
        NULL,
        'https://cdn.vibelink.com/music/28.jpg',
        'https://open.spotify.com/track/0VjIjW4GlUZAMYd2vXMi3b',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        29,
        2,
        'music_shape_of_you',
        NULL,
        'https://cdn.vibelink.com/music/29.jpg',
        'https://open.spotify.com/track/7qiZfU4dY1lWllzX7mPBI3',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        30,
        2,
        'music_hotel_california',
        NULL,
        'https://cdn.vibelink.com/music/30.jpg',
        'https://open.spotify.com/track/40riOy7x9W7GXjyGp4pjAv',
        'SPOTIFY',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    -- 조명 (category_id=3, items 31-45)
    (
        31,
        3,
        'light_warm_pendant',
        'Philips Hue',
        'https://cdn.vibelink.com/lighting/31.jpg',
        NULL,
        'HUE',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        32,
        3,
        'light_sunset_indirect',
        'Philips Hue',
        'https://cdn.vibelink.com/lighting/32.jpg',
        NULL,
        'HUE',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        33,
        3,
        'light_candle_warm',
        NULL,
        'https://cdn.vibelink.com/lighting/33.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        34,
        3,
        'light_moonlight_blue',
        'Philips Hue',
        'https://cdn.vibelink.com/lighting/34.jpg',
        NULL,
        'HUE',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        35,
        3,
        'light_daylight_natural',
        'IKEA',
        'https://cdn.vibelink.com/lighting/35.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        36,
        3,
        'light_reading_desk',
        'IKEA',
        'https://cdn.vibelink.com/lighting/36.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        37,
        3,
        'light_party_rgb',
        'Philips Hue',
        'https://cdn.vibelink.com/lighting/37.jpg',
        NULL,
        'HUE',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        38,
        3,
        'light_aurora_dynamic',
        'Philips Hue',
        'https://cdn.vibelink.com/lighting/38.jpg',
        NULL,
        'HUE',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        39,
        3,
        'light_cafe_ambient',
        NULL,
        'https://cdn.vibelink.com/lighting/39.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        40,
        3,
        'light_studio_bright',
        'IKEA',
        'https://cdn.vibelink.com/lighting/40.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        41,
        3,
        'light_romantic_pink',
        'Philips Hue',
        'https://cdn.vibelink.com/lighting/41.jpg',
        NULL,
        'HUE',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        42,
        3,
        'light_forest_green',
        NULL,
        'https://cdn.vibelink.com/lighting/42.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        43,
        3,
        'light_ocean_wave',
        'Philips Hue',
        'https://cdn.vibelink.com/lighting/43.jpg',
        NULL,
        'HUE',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        44,
        3,
        'light_sunrise_gradient',
        'Philips Hue',
        'https://cdn.vibelink.com/lighting/44.jpg',
        NULL,
        'HUE',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        45,
        3,
        'light_fireplace_flicker',
        NULL,
        'https://cdn.vibelink.com/lighting/45.jpg',
        NULL,
        'OTHER',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    -- 커피 (category_id=4, items 46-60)
    (
        46,
        4,
        'coffee_melozio',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/46.jpg',
        'https://www.nespresso.com/kr/ko/melozio',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        47,
        4,
        'coffee_napoli',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/47.jpg',
        'https://www.nespresso.com/kr/ko/napoli',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        48,
        4,
        'coffee_roma',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/48.jpg',
        'https://www.nespresso.com/kr/ko/roma',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        49,
        4,
        'coffee_ristretto',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/49.jpg',
        'https://www.nespresso.com/kr/ko/ristretto',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        50,
        4,
        'coffee_arpeggio',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/50.jpg',
        'https://www.nespresso.com/kr/ko/arpeggio',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        51,
        4,
        'coffee_livanto',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/51.jpg',
        'https://www.nespresso.com/kr/ko/livanto',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        52,
        4,
        'coffee_capriccio',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/52.jpg',
        'https://www.nespresso.com/kr/ko/capriccio',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        53,
        4,
        'coffee_volluto',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/53.jpg',
        'https://www.nespresso.com/kr/ko/volluto',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        54,
        4,
        'coffee_cosi',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/54.jpg',
        'https://www.nespresso.com/kr/ko/cosi',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        55,
        4,
        'coffee_kazaar',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/55.jpg',
        'https://www.nespresso.com/kr/ko/kazaar',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        56,
        4,
        'coffee_dharkan',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/56.jpg',
        'https://www.nespresso.com/kr/ko/dharkan',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        57,
        4,
        'coffee_stormio',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/57.jpg',
        'https://www.nespresso.com/kr/ko/stormio',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        58,
        4,
        'coffee_odacio',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/58.jpg',
        'https://www.nespresso.com/kr/ko/odacio',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        59,
        4,
        'coffee_giornio',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/59.jpg',
        'https://www.nespresso.com/kr/ko/giornio',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        60,
        4,
        'coffee_altissio',
        'Nespresso',
        'https://cdn.vibelink.com/coffee/60.jpg',
        'https://www.nespresso.com/kr/ko/altissio',
        'NESPRESSO',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ) ON CONFLICT (item_key) DO NOTHING;
-- ============================================================
-- LEVEL 2: References Level 0-1 — 12 tables
-- ============================================================
-- [15/44] social_accounts (15건)
INSERT INTO social_accounts (
        social_id,
        user_id,
        provider,
        provider_user_id,
        access_token,
        refresh_token,
        token_expires_at,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        'KAKAO',
        'kakao_uid_001',
        'at_kakao_001',
        'rt_kakao_001',
        '2026-06-01 00:00:00',
        '2025-06-01 10:00:00'
    ),
    (
        2,
        2,
        'GOOGLE',
        'google_uid_002',
        'at_google_002',
        'rt_google_002',
        '2026-06-05 00:00:00',
        '2025-06-05 11:00:00'
    ),
    (
        3,
        3,
        'NAVER',
        'naver_uid_003',
        'at_naver_003',
        'rt_naver_003',
        '2026-06-10 00:00:00',
        '2025-06-10 09:00:00'
    ),
    (
        4,
        4,
        'APPLE',
        'apple_uid_004',
        'at_apple_004',
        'rt_apple_004',
        '2026-07-01 00:00:00',
        '2025-07-01 15:00:00'
    ),
    (
        5,
        5,
        'KAKAO',
        'kakao_uid_005',
        'at_kakao_005',
        'rt_kakao_005',
        '2026-07-15 00:00:00',
        '2025-07-15 08:00:00'
    ),
    (
        6,
        6,
        'GOOGLE',
        'google_uid_006',
        'at_google_006',
        'rt_google_006',
        '2026-07-20 00:00:00',
        '2025-07-20 12:00:00'
    ),
    (
        7,
        7,
        'NAVER',
        'naver_uid_007',
        'at_naver_007',
        'rt_naver_007',
        '2026-08-01 00:00:00',
        '2025-08-01 10:00:00'
    ),
    (
        8,
        8,
        'APPLE',
        'apple_uid_008',
        'at_apple_008',
        'rt_apple_008',
        '2026-08-10 00:00:00',
        '2025-08-10 14:00:00'
    ),
    (
        9,
        9,
        'KAKAO',
        'kakao_uid_009',
        'at_kakao_009',
        'rt_kakao_009',
        '2026-08-20 00:00:00',
        '2025-08-20 09:00:00'
    ),
    (
        10,
        10,
        'GOOGLE',
        'google_uid_010',
        'at_google_010',
        'rt_google_010',
        '2026-09-01 00:00:00',
        '2025-09-01 11:00:00'
    ),
    (
        11,
        11,
        'NAVER',
        'naver_uid_011',
        'at_naver_011',
        'rt_naver_011',
        '2026-09-10 00:00:00',
        '2025-09-10 16:00:00'
    ),
    (
        12,
        12,
        'APPLE',
        'apple_uid_012',
        'at_apple_012',
        'rt_apple_012',
        '2026-09-15 00:00:00',
        '2025-09-15 13:00:00'
    ),
    (
        13,
        13,
        'KAKAO',
        'kakao_uid_013',
        'at_kakao_013',
        'rt_kakao_013',
        '2026-10-01 00:00:00',
        '2025-10-01 10:00:00'
    ),
    (
        14,
        14,
        'GOOGLE',
        'google_uid_014',
        'at_google_014',
        'rt_google_014',
        '2026-10-10 00:00:00',
        '2025-10-10 08:00:00'
    ),
    (
        15,
        15,
        'NAVER',
        'naver_uid_015',
        'at_naver_015',
        'rt_naver_015',
        '2026-10-20 00:00:00',
        '2025-10-20 14:00:00'
    ) ON CONFLICT (provider, provider_user_id) DO NOTHING;
-- [16/44] user_settings (15건, 1:1 with users)
INSERT INTO user_settings (
        setting_id,
        user_id,
        push_enabled,
        email_notification,
        default_share_privacy,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        TRUE,
        TRUE,
        'PRIVATE',
        '2025-06-01 10:00:00',
        '2025-06-01 10:00:00'
    ),
    (
        2,
        2,
        TRUE,
        FALSE,
        'PUBLIC',
        '2025-06-05 11:00:00',
        '2025-06-05 11:00:00'
    ),
    (
        3,
        3,
        TRUE,
        TRUE,
        'PRIVATE',
        '2025-06-10 09:00:00',
        '2025-06-10 09:00:00'
    ),
    (
        4,
        4,
        FALSE,
        TRUE,
        'PUBLIC',
        '2025-07-01 15:00:00',
        '2025-07-01 15:00:00'
    ),
    (
        5,
        5,
        TRUE,
        TRUE,
        'PRIVATE',
        '2025-07-15 08:00:00',
        '2025-07-15 08:00:00'
    ),
    (
        6,
        6,
        TRUE,
        FALSE,
        'PRIVATE',
        '2025-07-20 12:00:00',
        '2025-07-20 12:00:00'
    ),
    (
        7,
        7,
        FALSE,
        FALSE,
        'PUBLIC',
        '2025-08-01 10:00:00',
        '2025-08-01 10:00:00'
    ),
    (
        8,
        8,
        TRUE,
        TRUE,
        'PRIVATE',
        '2025-08-10 14:00:00',
        '2025-08-10 14:00:00'
    ),
    (
        9,
        9,
        TRUE,
        TRUE,
        'PRIVATE',
        '2025-08-20 09:00:00',
        '2025-08-20 09:00:00'
    ),
    (
        10,
        10,
        FALSE,
        TRUE,
        'PUBLIC',
        '2025-09-01 11:00:00',
        '2025-09-01 11:00:00'
    ),
    (
        11,
        11,
        TRUE,
        FALSE,
        'PRIVATE',
        '2025-09-10 16:00:00',
        '2025-09-10 16:00:00'
    ),
    (
        12,
        12,
        TRUE,
        TRUE,
        'PRIVATE',
        '2025-09-15 13:00:00',
        '2025-09-15 13:00:00'
    ),
    (
        13,
        13,
        TRUE,
        TRUE,
        'PUBLIC',
        '2025-10-01 10:00:00',
        '2025-10-01 10:00:00'
    ),
    (
        14,
        14,
        FALSE,
        FALSE,
        'PRIVATE',
        '2025-10-10 08:00:00',
        '2025-10-10 08:00:00'
    ),
    (
        15,
        15,
        TRUE,
        TRUE,
        'PRIVATE',
        '2025-10-20 14:00:00',
        '2025-10-20 14:00:00'
    ) ON CONFLICT (user_id) DO NOTHING;
-- [17/44] item_translations (15건: 영화 아이템 한국어 번역)
INSERT INTO item_translations (
        translation_id,
        item_id,
        language_id,
        item_value,
        description
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        1,
        '기생충',
        '계급 갈등을 다룬 봉준호 감독의 블랙 코미디'
    ),
    (
        2,
        2,
        1,
        '올드보이',
        '15년 감금 후 복수를 다룬 박찬욱 감독의 스릴러'
    ),
    (3, 3, 1, '부산행', '좀비 재난 속 KTX 탑승객들의 생존기'),
    (
        4,
        4,
        1,
        '미나리',
        '미국 이민 한국 가족의 아메리칸 드림 이야기'
    ),
    (
        5,
        5,
        1,
        '헤어질 결심',
        '형사와 용의자 사이 묘한 감정을 다룬 미스터리'
    ),
    (6, 6, 1, '인터스텔라', '시간과 사랑을 넘나드는 우주 탐험 SF 대작'),
    (7, 7, 1, '라라랜드', '꿈과 사랑 사이 갈등을 그린 뮤지컬 로맨스'),
    (
        8,
        8,
        1,
        '인셉션',
        '꿈속의 꿈을 파고드는 마인드 하이스트 스릴러'
    ),
    (
        9,
        9,
        1,
        '아바타',
        '판도라 행성에서 벌어지는 장대한 SF 서사시'
    ),
    (
        10,
        10,
        1,
        '매트릭스',
        '가상현실과 현실의 경계를 묻는 사이버펑크 액션'
    ),
    (
        11,
        11,
        1,
        '서울의 봄',
        '1979년 12.12 군사반란을 다룬 역사 드라마'
    ),
    (12, 12, 1, '범죄도시4', '마석도 형사의 통쾌한 범죄 소탕 액션'),
    (
        13,
        13,
        1,
        '파묘',
        '풍수사와 장의사가 벌이는 미스터리 오컬트'
    ),
    (14, 14, 1, '괴물', '한강에 나타난 괴생명체와 가족의 사투'),
    (
        15,
        15,
        1,
        '택시운전사',
        '1980년 광주를 목격한 택시기사의 실화 기반 드라마'
    ) ON CONFLICT (item_id, language_id) DO NOTHING;
-- [18/44] movie_details (15건)
INSERT INTO movie_details (
        item_id,
        tmdb_id,
        original_title,
        overview,
        release_date,
        runtime,
        vote_average,
        vote_count,
        popularity,
        poster_path,
        genres,
        keywords,
        production_countries,
        original_language,
        cast_info,
        release_dates,
        content_type,
        tmdb_updated_at,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        496243,
        'Parasite',
        '전원 백수인 기택 가족이 부유한 박 사장네 집에 하나씩 침투하면서 벌어지는 이야기',
        '2019-05-30',
        132,
        8.5,
        16000,
        85.3,
        '/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
        '["드라마","스릴러","코미디"]',
        '["계급","빈부격차"]',
        '["KR"]',
        'ko',
        '[{"name":"송강호","role":"기택"},{"name":"이선균","role":"동익"}]',
        '{"KR":"2019-05-30","US":"2019-10-11"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        2,
        670,
        'Oldboy',
        '이유도 모른 채 15년간 감금된 남자의 처절한 복수극',
        '2003-11-21',
        120,
        8.3,
        11000,
        42.1,
        '/uUwMwJzFmPDFmcGJfFGEq7MbX0n.jpg',
        '["스릴러","미스터리","드라마"]',
        '["복수","감금"]',
        '["KR"]',
        'ko',
        '[{"name":"최민식","role":"오대수"},{"name":"유지태","role":"이우진"}]',
        '{"KR":"2003-11-21"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        3,
        396535,
        'Train to Busan',
        '부산행 KTX에서 벌어지는 좀비 바이러스 서바이벌',
        '2016-07-20',
        118,
        7.8,
        9500,
        55.2,
        '/kFCjfRvMCFkYBQoIONOBwbQmMP3.jpg',
        '["액션","호러","스릴러"]',
        '["좀비","기차"]',
        '["KR"]',
        'ko',
        '[{"name":"공유","role":"석우"},{"name":"정유미","role":"성경"}]',
        '{"KR":"2016-07-20"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        4,
        615643,
        'Minari',
        '아칸소주 시골로 이주한 한국인 가족의 아메리칸 드림',
        '2020-12-11',
        115,
        7.5,
        3200,
        28.7,
        '/7RyBmEpegJDjOEGOUkNPpC5HBIL.jpg',
        '["드라마"]',
        '["이민","가족"]',
        '["US"]',
        'en',
        '[{"name":"스티븐 연","role":"제이콥"},{"name":"한예리","role":"모니카"}]',
        '{"US":"2020-12-11","KR":"2021-03-03"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        5,
        906221,
        'Decision to Leave',
        '산악 사고 사건을 조사하는 형사가 용의자에게 빠져드는 미스터리 로맨스',
        '2022-06-29',
        138,
        7.3,
        2800,
        35.4,
        '/tRF6Mhh0I6jr7VpNzH9GJRzIfPU.jpg',
        '["미스터리","로맨스","드라마"]',
        '["형사","용의자"]',
        '["KR"]',
        'ko',
        '[{"name":"박해일","role":"해준"},{"name":"탕웨이","role":"서래"}]',
        '{"KR":"2022-06-29"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        6,
        157336,
        'Interstellar',
        '인류의 생존을 위해 웜홀을 통과해 새로운 행성을 찾는 우주 탐험',
        '2014-11-05',
        169,
        8.6,
        33000,
        102.5,
        '/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
        '["SF","드라마","모험"]',
        '["우주","시간여행"]',
        '["US","GB"]',
        'en',
        '[{"name":"매튜 매커너히","role":"쿠퍼"},{"name":"앤 해서웨이","role":"브랜드"}]',
        '{"US":"2014-11-05","KR":"2014-11-06"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        7,
        313369,
        'La La Land',
        '재즈 피아니스트와 배우 지망생의 꿈과 사랑 이야기',
        '2016-12-09',
        128,
        7.9,
        15000,
        62.3,
        '/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg',
        '["뮤지컬","로맨스","드라마"]',
        '["꿈","재즈"]',
        '["US"]',
        'en',
        '[{"name":"라이언 고슬링","role":"세바스찬"},{"name":"엠마 스톤","role":"미아"}]',
        '{"US":"2016-12-09","KR":"2016-12-07"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        8,
        27205,
        'Inception',
        '타인의 꿈에 침투해 아이디어를 심는 마인드 하이스트',
        '2010-07-16',
        148,
        8.4,
        35000,
        95.8,
        '/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
        '["SF","액션","스릴러"]',
        '["꿈","무의식"]',
        '["US","GB"]',
        'en',
        '[{"name":"레오나르도 디카프리오","role":"콥"},{"name":"조셉 고든 레빗","role":"아서"}]',
        '{"US":"2010-07-16","KR":"2010-07-21"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        9,
        19995,
        'Avatar',
        '판도라 행성에서 나비족과 인간 사이 갈등을 그린 SF 서사시',
        '2009-12-18',
        162,
        7.6,
        29000,
        88.2,
        '/jRXYjXNq0Cs2TcJjLkki98lbIIv.jpg',
        '["SF","액션","모험"]',
        '["외계","자연"]',
        '["US"]',
        'en',
        '[{"name":"샘 워싱턴","role":"제이크"},{"name":"조 살다나","role":"네이티리"}]',
        '{"US":"2009-12-18","KR":"2009-12-17"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        10,
        603,
        'The Matrix',
        '가상현실 매트릭스의 진실을 깨닫는 해커 네오의 여정',
        '1999-03-31',
        136,
        8.2,
        25000,
        78.9,
        '/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
        '["SF","액션"]',
        '["가상현실","해커"]',
        '["US"]',
        'en',
        '[{"name":"키아누 리브스","role":"네오"},{"name":"로렌스 피시번","role":"모피어스"}]',
        '{"US":"1999-03-31","KR":"1999-05-15"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        11,
        1072790,
        '12.12: The Day',
        '1979년 12월 12일 군사 반란의 9시간을 재현한 역사 드라마',
        '2023-11-22',
        141,
        7.7,
        5200,
        45.6,
        '/sKqBiGaIPTp0s2LOz0yzW3BJNQT.jpg',
        '["드라마","역사"]',
        '["군사반란","민주화"]',
        '["KR"]',
        'ko',
        '[{"name":"황정민","role":"전두광"},{"name":"정우성","role":"이태신"}]',
        '{"KR":"2023-11-22"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        12,
        1115396,
        'The Roundup: Punishment',
        '괴물 형사 마석도의 신종 마약 소탕 작전',
        '2024-05-22',
        109,
        7.1,
        3800,
        38.2,
        '/placeholder12.jpg',
        '["액션","범죄"]',
        '["형사","마약"]',
        '["KR"]',
        'ko',
        '[{"name":"마동석","role":"마석도"},{"name":"김무열","role":"백창기"}]',
        '{"KR":"2024-05-22"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        13,
        1116173,
        'Exhuma',
        '풍수사와 장의사가 명문가 저주의 비밀을 파헤치는 오컬트',
        '2024-02-22',
        134,
        7.4,
        4100,
        41.3,
        '/placeholder13.jpg',
        '["호러","미스터리"]',
        '["풍수","오컬트"]',
        '["KR"]',
        'ko',
        '[{"name":"최민식","role":"김상덕"},{"name":"김고은","role":"화림"}]',
        '{"KR":"2024-02-22"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        14,
        1815,
        'The Host',
        '한강에서 출현한 괴생명체에 맞서 싸우는 가족의 이야기',
        '2006-07-27',
        119,
        7.1,
        2900,
        22.5,
        '/placeholder14.jpg',
        '["SF","드라마","호러"]',
        '["괴물","가족"]',
        '["KR"]',
        'ko',
        '[{"name":"송강호","role":"강두"},{"name":"배두나","role":"남주"}]',
        '{"KR":"2006-07-27"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        15,
        442168,
        'A Taxi Driver',
        '1980년 광주 민주화운동을 목격한 서울 택시기사의 실화',
        '2017-08-02',
        137,
        7.9,
        4500,
        33.8,
        '/placeholder15.jpg',
        '["드라마","역사"]',
        '["광주","민주화"]',
        '["KR"]',
        'ko',
        '[{"name":"송강호","role":"김만섭"},{"name":"토마스 크레취만","role":"위르겐"}]',
        '{"KR":"2017-08-02"}',
        'MOVIE',
        '2025-11-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ) ON CONFLICT (item_id) DO NOTHING;
-- [19/44] music_details (15건)
INSERT INTO music_details (
        item_id,
        musicbrainz_id,
        isrc,
        artists,
        album_name,
        album_cover_url,
        track_duration_ms,
        release_date,
        genres,
        deezer_id,
        preview_url,
        spotify_uri,
        lyrics,
        content_type,
        source_updated_at,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        16,
        'mbid-0001-spring-day',
        'KRA382100001',
        '["BTS"]',
        '화양연화 Young Forever',
        'https://cdn.vibelink.com/album/16.jpg',
        274000,
        '2017-02-13',
        '["K-Pop","발라드"]',
        100001,
        'https://cdns-preview-d.dzcdn.net/stream/1.mp3',
        'spotify:track:0xqiGOyDpB1JMa0on01dEr',
        '보고 싶다 이렇게 말하니까 더 보고 싶다...',
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        17,
        'mbid-0002-dynamite',
        'KRA382000002',
        '["BTS"]',
        'Dynamite (DayTime Version)',
        'https://cdn.vibelink.com/album/17.jpg',
        199000,
        '2020-08-21',
        '["K-Pop","디스코"]',
        100002,
        'https://cdns-preview-d.dzcdn.net/stream/2.mp3',
        'spotify:track:5QDLhrAOJJdNAmCTJ8xMyW',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        18,
        'mbid-0003-love-dive',
        'KRA492200003',
        '["IVE"]',
        'LOVE DIVE',
        'https://cdn.vibelink.com/album/18.jpg',
        177000,
        '2022-04-05',
        '["K-Pop","댄스"]',
        100003,
        'https://cdns-preview-d.dzcdn.net/stream/3.mp3',
        'spotify:track:0LBFI6ATm1Aw1iEEJJx1Fj',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        19,
        'mbid-0004-hype-boy',
        'KRA492200004',
        '["NewJeans"]',
        'NewJeans 1st EP',
        'https://cdn.vibelink.com/album/19.jpg',
        178000,
        '2022-08-01',
        '["K-Pop","R&B"]',
        100004,
        'https://cdns-preview-d.dzcdn.net/stream/4.mp3',
        'spotify:track:0a4MMyCrzT0En247IhqZbD',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        20,
        'mbid-0005-super-shy',
        'KRA492300005',
        '["NewJeans"]',
        'Get Up',
        'https://cdn.vibelink.com/album/20.jpg',
        152000,
        '2023-07-07',
        '["K-Pop","팝"]',
        100005,
        'https://cdns-preview-d.dzcdn.net/stream/5.mp3',
        'spotify:track:5sdQOyqq2IDhvmx2lHOpwd',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        21,
        'mbid-0006-antifragile',
        'KRA552200006',
        '["LE SSERAFIM"]',
        'ANTIFRAGILE',
        'https://cdn.vibelink.com/album/21.jpg',
        186000,
        '2022-10-17',
        '["K-Pop","힙합"]',
        100006,
        'https://cdns-preview-d.dzcdn.net/stream/6.mp3',
        'spotify:track:4IRGrCMWVPhk3m1OIRjPGT',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        22,
        'mbid-0007-ditto',
        'KRA492200007',
        '["NewJeans"]',
        'Ditto',
        'https://cdn.vibelink.com/album/22.jpg',
        186000,
        '2022-12-19',
        '["K-Pop","인디팝"]',
        100007,
        'https://cdns-preview-d.dzcdn.net/stream/7.mp3',
        'spotify:track:3r8RuvgbX9s7ammBn07D3W',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        23,
        'mbid-0008-next-level',
        'KRA382100008',
        '["aespa"]',
        'Next Level',
        'https://cdn.vibelink.com/album/23.jpg',
        236000,
        '2021-05-17',
        '["K-Pop","일렉트로닉"]',
        100008,
        'https://cdns-preview-d.dzcdn.net/stream/8.mp3',
        'spotify:track:2zrhoHlFKxFTRF5K1eFNFn',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        24,
        'mbid-0009-good-day',
        'KRA381000009',
        '["IU"]',
        'Real',
        'https://cdn.vibelink.com/album/24.jpg',
        231000,
        '2010-12-09',
        '["K-Pop","발라드"]',
        100009,
        'https://cdns-preview-d.dzcdn.net/stream/9.mp3',
        'spotify:track:4GGf3FRMhSuvNJboj04aBt',
        '좋은 날이잖아 오늘은 정말로...',
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        25,
        'mbid-0010-celebrity',
        'KRA382100010',
        '["IU"]',
        'LILAC',
        'https://cdn.vibelink.com/album/25.jpg',
        195000,
        '2021-03-25',
        '["K-Pop","팝"]',
        100010,
        'https://cdns-preview-d.dzcdn.net/stream/10.mp3',
        'spotify:track:5nCwjMqSPMCEiMkgmJOHRf',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        26,
        'mbid-0011-night-letter',
        'KRA381700011',
        '["IU"]',
        '밤편지',
        'https://cdn.vibelink.com/album/26.jpg',
        258000,
        '2017-03-24',
        '["K-Pop","발라드"]',
        100011,
        'https://cdns-preview-d.dzcdn.net/stream/11.mp3',
        'spotify:track:3MjUtNVVq3C8Fn0MP3zhXa',
        '이 밤 그날의 반딧불을 당신의 창 가까이...',
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        27,
        'mbid-0012-bohemian',
        'GBAYE7500101',
        '["Queen"]',
        'A Night at the Opera',
        'https://cdn.vibelink.com/album/27.jpg',
        354000,
        '1975-10-31',
        '["록","프로그레시브"]',
        100012,
        'https://cdns-preview-d.dzcdn.net/stream/12.mp3',
        'spotify:track:4u7EnebtmKWzUH433cf5Qv',
        'Is this the real life? Is this just fantasy?...',
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        28,
        'mbid-0013-blinding',
        'USUG12000497',
        '["The Weeknd"]',
        'After Hours',
        'https://cdn.vibelink.com/album/28.jpg',
        200000,
        '2020-03-20',
        '["팝","신스팝"]',
        100013,
        'https://cdns-preview-d.dzcdn.net/stream/13.mp3',
        'spotify:track:0VjIjW4GlUZAMYd2vXMi3b',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        29,
        'mbid-0014-shape-of-you',
        'GBAHS1600463',
        '["Ed Sheeran"]',
        'Divide',
        'https://cdn.vibelink.com/album/29.jpg',
        233000,
        '2017-01-06',
        '["팝","댄스팝"]',
        100014,
        'https://cdns-preview-d.dzcdn.net/stream/14.mp3',
        'spotify:track:7qiZfU4dY1lWllzX7mPBI3',
        NULL,
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        30,
        'mbid-0015-hotel-calif',
        'USEE17600011',
        '["Eagles"]',
        'Hotel California',
        'https://cdn.vibelink.com/album/30.jpg',
        391000,
        '1977-02-22',
        '["록","소프트록"]',
        100015,
        'https://cdns-preview-d.dzcdn.net/stream/15.mp3',
        'spotify:track:40riOy7x9W7GXjyGp4pjAv',
        'On a dark desert highway, cool wind in my hair...',
        'TRACK',
        '2025-10-01 00:00:00',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ) ON CONFLICT (item_id) DO NOTHING;
-- [20/44] lighting_details (15건)
INSERT INTO lighting_details (
        item_id,
        lighting_key,
        color_temp_kelvin,
        color_temp_name,
        brightness_percent,
        brightness_level,
        lighting_type,
        light_color,
        position,
        space_context,
        time_context,
        is_dynamic,
        dynamic_start_kelvin,
        dynamic_end_kelvin,
        linked_product_id,
        hue_scene_id,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        31,
        'warm_pendant_cozy',
        2700,
        '전구색',
        40,
        '은은한',
        '펜던트',
        '웜화이트',
        '천장',
        '거실, 침실',
        '저녁~밤',
        FALSE,
        NULL,
        NULL,
        NULL,
        'hue_scene_001',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        32,
        'sunset_indirect_amber',
        2200,
        '촛불색',
        30,
        '은은한',
        '간접조명',
        '앰버',
        '벽면',
        '거실, 서재',
        '오후~저녁',
        TRUE,
        3500,
        2200,
        NULL,
        'hue_scene_002',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        33,
        'candle_warm_romantic',
        1800,
        '촛불색',
        20,
        '아주은은한',
        '캔들',
        '웜화이트',
        '테이블',
        '침실, 레스토랑',
        '밤',
        FALSE,
        NULL,
        NULL,
        NULL,
        NULL,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        34,
        'moonlight_blue_calm',
        6500,
        '주광색',
        25,
        '은은한',
        '간접조명',
        '블루',
        '천장',
        '침실',
        '밤~새벽',
        FALSE,
        NULL,
        NULL,
        NULL,
        'hue_scene_003',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        35,
        'daylight_natural_focus',
        5000,
        '자연광',
        80,
        '밝은',
        'LED패널',
        '화이트',
        '천장',
        '서재, 사무실',
        '오전~오후',
        FALSE,
        NULL,
        NULL,
        NULL,
        NULL,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        36,
        'reading_desk_warm',
        3500,
        '주백색',
        60,
        '적당한',
        '데스크램프',
        '웜화이트',
        '책상',
        '서재',
        '저녁',
        FALSE,
        NULL,
        NULL,
        NULL,
        NULL,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        37,
        'party_rgb_vivid',
        0,
        '멀티컬러',
        90,
        '밝은',
        'LED스트립',
        'RGB',
        '벽면',
        '거실, 파티룸',
        '밤',
        TRUE,
        0,
        0,
        NULL,
        'hue_scene_004',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        38,
        'aurora_dynamic_dream',
        0,
        '멀티컬러',
        50,
        '적당한',
        '프로젝터',
        '퍼플',
        '천장',
        '침실',
        '밤',
        TRUE,
        3000,
        6000,
        NULL,
        'hue_scene_005',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        39,
        'cafe_ambient_cozy',
        2700,
        '전구색',
        35,
        '은은한',
        '펜던트',
        '웜화이트',
        '천장',
        '카페, 거실',
        '오후~저녁',
        FALSE,
        NULL,
        NULL,
        NULL,
        NULL,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        40,
        'studio_bright_work',
        5500,
        '주광색',
        95,
        '아주밝은',
        'LED패널',
        '화이트',
        '천장',
        '작업실, 사무실',
        '오전~오후',
        FALSE,
        NULL,
        NULL,
        NULL,
        NULL,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        41,
        'romantic_pink_glow',
        3000,
        '전구색',
        30,
        '은은한',
        '간접조명',
        '핑크',
        '벽면',
        '침실',
        '저녁~밤',
        FALSE,
        NULL,
        NULL,
        NULL,
        'hue_scene_006',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        42,
        'forest_green_relax',
        4000,
        '주백색',
        45,
        '적당한',
        'LED스트립',
        '그린',
        '바닥',
        '거실, 발코니',
        '오후',
        FALSE,
        NULL,
        NULL,
        NULL,
        NULL,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        43,
        'ocean_wave_blue',
        0,
        '멀티컬러',
        40,
        '은은한',
        '프로젝터',
        '블루',
        '천장',
        '침실, 욕실',
        '밤',
        TRUE,
        4500,
        6500,
        NULL,
        'hue_scene_007',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        44,
        'sunrise_gradient_wake',
        3000,
        '전구색',
        70,
        '밝은',
        '간접조명',
        '오렌지',
        '벽면',
        '침실',
        '새벽~아침',
        TRUE,
        2200,
        5000,
        NULL,
        'hue_scene_008',
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        45,
        'fireplace_flicker_warm',
        2000,
        '촛불색',
        25,
        '은은한',
        'LED캔들',
        '웜화이트',
        '바닥',
        '거실',
        '저녁~밤',
        TRUE,
        1800,
        2500,
        NULL,
        NULL,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ) ON CONFLICT (item_id) DO NOTHING;
-- [21/44] coffee_details (15건)
INSERT INTO coffee_details (
        item_id,
        capsule_key,
        capsule_name,
        line,
        sub_category,
        intensity,
        intensity_max,
        cup_sizes,
        bean_type,
        origins,
        roast_level,
        aroma_profile,
        flavor_notes,
        body,
        bitterness,
        acidity,
        roasting,
        is_decaf,
        is_limited_edition,
        price_per_capsule_krw,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        46,
        'melozio',
        '멜로지오',
        'VERTUO',
        '머그',
        6,
        12,
        '[{"type":"MUG","ml":230}]',
        '100% Arabica',
        '["브라질","콜롬비아"]',
        'MEDIUM',
        '{"primary":["꿀","비스킷"]}',
        '부드럽고 달콤한 꿀과 비스킷 풍미',
        3,
        2,
        2,
        3,
        FALSE,
        FALSE,
        990,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        47,
        'napoli',
        '나폴리',
        'ORIGINAL',
        '에스프레소',
        13,
        14,
        '[{"type":"RISTRETTO","ml":25},{"type":"ESPRESSO","ml":40}]',
        NULL,
        '["에티오피아","브라질"]',
        'DARK',
        '{"primary":["스파이시","우디"]}',
        '강렬하고 스파이시한 나폴리 전통 에스프레소',
        5,
        5,
        1,
        5,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        48,
        'roma',
        '로마',
        'ORIGINAL',
        '에스프레소',
        8,
        14,
        '[{"type":"RISTRETTO","ml":25},{"type":"ESPRESSO","ml":40}]',
        '100% Arabica',
        '["브라질","콜롬비아"]',
        'MEDIUM',
        '{"primary":["견과류","우디"]}',
        '우아한 견과류 향과 우디 노트',
        4,
        3,
        2,
        3,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        49,
        'ristretto',
        '리스트레토',
        'ORIGINAL',
        '에스프레소',
        10,
        14,
        '[{"type":"RISTRETTO","ml":25}]',
        '100% Arabica',
        '["콜롬비아","케냐"]',
        'MEDIUM',
        '{"primary":["과일","시트러스"]}',
        '풍부하고 과일향 가득한 리스트레토',
        4,
        3,
        3,
        3,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        50,
        'arpeggio',
        '아르페지오',
        'ORIGINAL',
        '에스프레소',
        9,
        14,
        '[{"type":"RISTRETTO","ml":25},{"type":"ESPRESSO","ml":40}]',
        '100% Arabica',
        '["코스타리카","콜롬비아"]',
        'DARK',
        '{"primary":["코코아","구운빵"]}',
        '진한 코코아 풍미의 크리미한 에스프레소',
        4,
        4,
        2,
        4,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        51,
        'livanto',
        '리반토',
        'ORIGINAL',
        '에스프레소',
        6,
        14,
        '[{"type":"ESPRESSO","ml":40}]',
        '100% Arabica',
        '["에티오피아","콜롬비아"]',
        'MEDIUM',
        '{"primary":["캐러멜","곡물"]}',
        '균형 잡힌 캐러멜 풍미의 에스프레소',
        3,
        2,
        2,
        3,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        52,
        'capriccio',
        '카프리치오',
        'ORIGINAL',
        '에스프레소',
        5,
        14,
        '[{"type":"ESPRESSO","ml":40}]',
        '100% Arabica',
        '["브라질"]',
        'MEDIUM',
        '{"primary":["곡물","견과류"]}',
        '가벼운 곡물향의 밸런스 좋은 에스프레소',
        3,
        2,
        2,
        2,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        53,
        'volluto',
        '볼루토',
        'ORIGINAL',
        '에스프레소',
        4,
        14,
        '[{"type":"ESPRESSO","ml":40}]',
        '100% Arabica',
        '["브라질","콜롬비아"]',
        'MEDIUM',
        '{"primary":["비스킷","과일"]}',
        '달콤한 비스킷과 과일 노트의 라이트 에스프레소',
        2,
        1,
        2,
        2,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        54,
        'cosi',
        '코시',
        'ORIGINAL',
        '에스프레소',
        3,
        14,
        '[{"type":"ESPRESSO","ml":40}]',
        '100% Arabica',
        '["에티오피아","케냐"]',
        'MEDIUM',
        '{"primary":["시트러스","곡물"]}',
        '상쾌한 시트러스향의 라이트 에스프레소',
        2,
        1,
        3,
        2,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        55,
        'kazaar',
        '카자르',
        'ORIGINAL',
        '에스프레소',
        12,
        14,
        '[{"type":"RISTRETTO","ml":25},{"type":"ESPRESSO","ml":40}]',
        NULL,
        '["브라질","과테말라"]',
        'DARK',
        '{"primary":["후추","우디","견과류"]}',
        '대담하고 강렬한 후추 풍미의 에스프레소',
        5,
        5,
        1,
        5,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        56,
        'dharkan',
        '다칸',
        'ORIGINAL',
        '에스프레소',
        11,
        14,
        '[{"type":"RISTRETTO","ml":25},{"type":"ESPRESSO","ml":40}]',
        '100% Arabica',
        '["인도","라틴 아메리카"]',
        'DARK',
        '{"primary":["초콜릿","아몬드"]}',
        '벨벳 같은 다크 초콜릿과 아몬드 풍미',
        5,
        4,
        1,
        4,
        FALSE,
        FALSE,
        790,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        57,
        'stormio',
        '스토르미오',
        'VERTUO',
        '머그',
        8,
        12,
        '[{"type":"MUG","ml":230}]',
        NULL,
        '["니카라과","과테말라"]',
        'DARK',
        '{"primary":["우디","스모키"]}',
        '우디하고 스모키한 풀바디 머그 커피',
        4,
        4,
        1,
        4,
        FALSE,
        FALSE,
        990,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        58,
        'odacio',
        '오다시오',
        'VERTUO',
        '머그',
        5,
        12,
        '[{"type":"MUG","ml":230}]',
        '100% Arabica',
        '["에티오피아"]',
        'MEDIUM',
        '{"primary":["곡물","과일"]}',
        '깔끔한 곡물향과 과일 노트의 머그 커피',
        3,
        2,
        3,
        2,
        FALSE,
        FALSE,
        990,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        59,
        'giornio',
        '지오르니오',
        'VERTUO',
        '머그',
        4,
        12,
        '[{"type":"MUG","ml":230}]',
        '100% Arabica',
        '["브라질","콜롬비아"]',
        'MEDIUM',
        '{"primary":["꽃","곡물"]}',
        '섬세한 꽃향과 곡물의 조화로운 머그 커피',
        2,
        1,
        2,
        2,
        FALSE,
        FALSE,
        990,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        60,
        'altissio',
        '알티시오',
        'VERTUO',
        '에스프레소',
        9,
        12,
        '[{"type":"ESPRESSO","ml":40}]',
        '100% Arabica',
        '["콜롬비아","에티오피아"]',
        'DARK',
        '{"primary":["캐러멜","크리미"]}',
        '크리미하고 캐러멜 풍미의 버투오 에스프레소',
        4,
        3,
        2,
        4,
        FALSE,
        FALSE,
        990,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ) ON CONFLICT (item_id) DO NOTHING;
-- [22/44] neo4j_sync_status (15건)
INSERT INTO neo4j_sync_status (
        sync_id,
        item_id,
        sync_status,
        neo4j_node_id,
        last_synced_at,
        retry_count,
        error_message,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        'SYNCED',
        'neo4j_node_001',
        '2025-12-01 01:00:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:00:00'
    ),
    (
        2,
        2,
        'SYNCED',
        'neo4j_node_002',
        '2025-12-01 01:01:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:01:00'
    ),
    (
        3,
        3,
        'SYNCED',
        'neo4j_node_003',
        '2025-12-01 01:02:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:02:00'
    ),
    (
        4,
        16,
        'SYNCED',
        'neo4j_node_016',
        '2025-12-01 01:03:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:03:00'
    ),
    (
        5,
        17,
        'SYNCED',
        'neo4j_node_017',
        '2025-12-01 01:04:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:04:00'
    ),
    (
        6,
        31,
        'SYNCED',
        'neo4j_node_031',
        '2025-12-01 01:05:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:05:00'
    ),
    (
        7,
        46,
        'SYNCED',
        'neo4j_node_046',
        '2025-12-01 01:06:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:06:00'
    ),
    (
        8,
        4,
        'PENDING',
        NULL,
        NULL,
        0,
        NULL,
        '2025-12-01 02:00:00',
        '2025-12-01 02:00:00'
    ),
    (
        9,
        5,
        'PROCESSING',
        NULL,
        NULL,
        1,
        NULL,
        '2025-12-01 02:01:00',
        '2025-12-01 02:05:00'
    ),
    (
        10,
        18,
        'FAILED',
        NULL,
        NULL,
        3,
        'Connection timeout to Neo4j',
        '2025-12-01 02:02:00',
        '2025-12-01 02:10:00'
    ),
    (
        11,
        32,
        'SYNCED',
        'neo4j_node_032',
        '2025-12-01 01:07:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:07:00'
    ),
    (
        12,
        47,
        'SYNCED',
        'neo4j_node_047',
        '2025-12-01 01:08:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:08:00'
    ),
    (
        13,
        6,
        'SYNCED',
        'neo4j_node_006',
        '2025-12-01 01:09:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:09:00'
    ),
    (
        14,
        19,
        'PENDING',
        NULL,
        NULL,
        0,
        NULL,
        '2025-12-01 03:00:00',
        '2025-12-01 03:00:00'
    ),
    (
        15,
        33,
        'SYNCED',
        'neo4j_node_033',
        '2025-12-01 01:10:00',
        0,
        NULL,
        '2025-06-01 00:00:00',
        '2025-12-01 01:10:00'
    ) ON CONFLICT (item_id) DO NOTHING;
-- [23/44] vibe_sessions (15건)
INSERT INTO vibe_sessions (
        session_id,
        user_id,
        status,
        created_at,
        completed_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        'COMPLETED',
        '2025-11-01 10:00:00',
        '2025-11-01 10:05:00'
    ),
    (
        2,
        2,
        'COMPLETED',
        '2025-11-02 14:30:00',
        '2025-11-02 14:33:00'
    ),
    (
        3,
        3,
        'COMPLETED',
        '2025-11-03 09:15:00',
        '2025-11-03 09:19:00'
    ),
    (
        4,
        4,
        'COMPLETED',
        '2025-11-04 20:00:00',
        '2025-11-04 20:04:00'
    ),
    (
        5,
        5,
        'COMPLETED',
        '2025-11-05 16:45:00',
        '2025-11-05 16:49:00'
    ),
    (
        6,
        6,
        'COMPLETED',
        '2025-11-06 08:30:00',
        '2025-11-06 08:35:00'
    ),
    (
        7,
        7,
        'COMPLETED',
        '2025-11-07 22:10:00',
        '2025-11-07 22:14:00'
    ),
    (
        8,
        8,
        'COMPLETED',
        '2025-11-08 11:20:00',
        '2025-11-08 11:24:00'
    ),
    (
        9,
        9,
        'COMPLETED',
        '2025-11-09 15:00:00',
        '2025-11-09 15:04:00'
    ),
    (
        10,
        10,
        'COMPLETED',
        '2025-11-10 19:30:00',
        '2025-11-10 19:35:00'
    ),
    (
        11,
        11,
        'COMPLETED',
        '2025-11-11 07:45:00',
        '2025-11-11 07:50:00'
    ),
    (
        12,
        12,
        'IN_PROGRESS',
        '2025-11-12 13:00:00',
        NULL
    ),
    (
        13,
        13,
        'COMPLETED',
        '2025-11-13 17:15:00',
        '2025-11-13 17:20:00'
    ),
    (
        14,
        14,
        'CANCELLED',
        '2025-11-14 21:30:00',
        NULL
    ),
    (
        15,
        15,
        'COMPLETED',
        '2025-11-15 10:30:00',
        '2025-11-15 10:35:00'
    ) ON CONFLICT (session_id) DO NOTHING;
-- [24/44] archive_folders (15건)
INSERT INTO archive_folders (
        folder_id,
        user_id,
        folder_name,
        thumbnail_url,
        sort_order,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        '나의 무드',
        NULL,
        0,
        '2025-11-01 10:10:00',
        '2025-11-01 10:10:00'
    ),
    (
        2,
        2,
        '감성 컬렉션',
        NULL,
        0,
        '2025-11-02 14:40:00',
        '2025-11-02 14:40:00'
    ),
    (
        3,
        3,
        '비 오는 날 모음',
        NULL,
        0,
        '2025-11-03 09:25:00',
        '2025-11-03 09:25:00'
    ),
    (
        4,
        4,
        '힐링 타임',
        NULL,
        0,
        '2025-11-04 20:10:00',
        '2025-11-04 20:10:00'
    ),
    (
        5,
        5,
        '업무 집중 모드',
        NULL,
        0,
        '2025-11-05 16:55:00',
        '2025-11-05 16:55:00'
    ),
    (
        6,
        6,
        '아침 루틴',
        NULL,
        0,
        '2025-11-06 08:40:00',
        '2025-11-06 08:40:00'
    ),
    (
        7,
        7,
        '밤 산책 무드',
        NULL,
        0,
        '2025-11-07 22:20:00',
        '2025-11-07 22:20:00'
    ),
    (
        8,
        8,
        '카페 분위기',
        NULL,
        0,
        '2025-11-08 11:30:00',
        '2025-11-08 11:30:00'
    ),
    (
        9,
        9,
        '운동 후 릴렉스',
        NULL,
        0,
        '2025-11-09 15:10:00',
        '2025-11-09 15:10:00'
    ),
    (
        10,
        10,
        '공부 모드',
        NULL,
        0,
        '2025-11-10 19:40:00',
        '2025-11-10 19:40:00'
    ),
    (
        11,
        11,
        '주말 여유',
        NULL,
        0,
        '2025-11-11 07:55:00',
        '2025-11-11 07:55:00'
    ),
    (
        12,
        12,
        '요리할 때',
        NULL,
        0,
        '2025-11-12 13:10:00',
        '2025-11-12 13:10:00'
    ),
    (
        13,
        13,
        '감성 영화 밤',
        NULL,
        0,
        '2025-11-13 17:25:00',
        '2025-11-13 17:25:00'
    ),
    (
        14,
        14,
        '데이트 무드',
        NULL,
        0,
        '2025-11-14 21:40:00',
        '2025-11-14 21:40:00'
    ),
    (
        15,
        15,
        '새벽 감성',
        NULL,
        0,
        '2025-11-15 10:40:00',
        '2025-11-15 10:40:00'
    ) ON CONFLICT (folder_id) DO NOTHING;
-- [25/44] follows (15건)
INSERT INTO follows (follow_id, follower_id, following_id, created_at) OVERRIDING SYSTEM VALUE
VALUES (1, 1, 2, '2025-07-01 10:00:00'),
    (2, 1, 3, '2025-07-02 11:00:00'),
    (3, 2, 1, '2025-07-01 12:00:00'),
    (4, 2, 4, '2025-07-03 14:00:00'),
    (5, 3, 1, '2025-07-02 09:00:00'),
    (6, 3, 5, '2025-07-04 16:00:00'),
    (7, 4, 2, '2025-07-05 08:00:00'),
    (8, 4, 6, '2025-07-06 10:00:00'),
    (9, 5, 3, '2025-07-07 13:00:00'),
    (10, 5, 7, '2025-07-08 15:00:00'),
    (11, 6, 1, '2025-07-09 17:00:00'),
    (12, 7, 2, '2025-07-10 11:00:00'),
    (13, 8, 3, '2025-07-11 09:00:00'),
    (14, 9, 4, '2025-07-12 14:00:00'),
    (15, 10, 5, '2025-07-13 16:00:00') ON CONFLICT (follower_id, following_id) DO NOTHING;
-- [26/44] notifications (15건)
INSERT INTO notifications (
        notification_id,
        user_id,
        type,
        title,
        body,
        link_url,
        reference_id,
        is_read,
        created_at,
        read_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        2,
        'FOLLOW',
        '김민준님이 팔로우했습니다',
        '김민준님이 당신을 팔로우하기 시작했습니다.',
        '/profile/1',
        1,
        TRUE,
        '2025-07-01 12:00:00',
        '2025-07-01 13:00:00'
    ),
    (
        2,
        1,
        'FOLLOW',
        '이서연님이 팔로우했습니다',
        '이서연님이 당신을 팔로우하기 시작했습니다.',
        '/profile/2',
        3,
        TRUE,
        '2025-07-01 12:05:00',
        '2025-07-01 14:00:00'
    ),
    (
        3,
        1,
        'FEED_REACTION',
        '이서연님이 반응했습니다',
        '이서연님이 당신의 피드에 좋아요를 눌렀습니다.',
        '/feed/1',
        NULL,
        TRUE,
        '2025-11-02 15:00:00',
        '2025-11-02 16:00:00'
    ),
    (
        4,
        2,
        'FEED_COMMENT',
        '박지호님이 댓글을 달았습니다',
        '박지호님: 분위기 좋네요!',
        '/feed/2',
        NULL,
        FALSE,
        '2025-11-03 10:00:00',
        NULL
    ),
    (
        5,
        3,
        'SYSTEM',
        '새로운 기능이 추가되었습니다',
        'Vibe 리포트 기능이 업데이트되었습니다.',
        '/report',
        NULL,
        FALSE,
        '2025-11-15 09:00:00',
        NULL
    ),
    (
        6,
        4,
        'FEED_REACTION',
        '정도윤님이 반응했습니다',
        '정도윤님이 당신의 피드에 LOVE 반응을 보냈습니다.',
        '/feed/4',
        NULL,
        TRUE,
        '2025-11-05 17:00:00',
        '2025-11-05 18:00:00'
    ),
    (
        7,
        5,
        'FOLLOW',
        '박지호님이 팔로우했습니다',
        '박지호님이 당신을 팔로우하기 시작했습니다.',
        '/profile/3',
        6,
        TRUE,
        '2025-07-04 16:05:00',
        '2025-07-04 17:00:00'
    ),
    (
        8,
        6,
        'FEED_COMMENT',
        '강하준님이 댓글을 달았습니다',
        '강하준님: 이 조명 어디서 구매할 수 있나요?',
        '/feed/6',
        NULL,
        FALSE,
        '2025-11-07 23:00:00',
        NULL
    ),
    (
        9,
        7,
        'SYSTEM',
        '월간 리포트가 생성되었습니다',
        '11월 Vibe 리포트를 확인해보세요.',
        '/report/7',
        NULL,
        FALSE,
        '2025-12-01 09:00:00',
        NULL
    ),
    (
        10,
        8,
        'FEED_REACTION',
        '윤지은님이 반응했습니다',
        '임태현님이 당신의 피드에 WOW 반응을 보냈습니다.',
        '/feed/8',
        NULL,
        TRUE,
        '2025-11-09 15:30:00',
        '2025-11-09 16:00:00'
    ),
    (
        11,
        9,
        'FOLLOW',
        '최수아님이 팔로우했습니다',
        '최수아님이 당신을 팔로우하기 시작했습니다.',
        '/profile/4',
        14,
        FALSE,
        '2025-07-12 14:05:00',
        NULL
    ),
    (
        12,
        10,
        'REPORT_READY',
        '연간 리포트 준비 완료',
        '2025년 연간 감성 리포트가 준비되었습니다.',
        '/report/10',
        NULL,
        FALSE,
        '2025-12-15 09:00:00',
        NULL
    ),
    (
        13,
        11,
        'FEED_REACTION',
        '서준우님의 피드에 반응이 달렸습니다',
        '오수빈님이 당신의 피드에 COZY 반응을 보냈습니다.',
        '/feed/11',
        NULL,
        TRUE,
        '2025-11-12 08:00:00',
        '2025-11-12 09:00:00'
    ),
    (
        14,
        13,
        'FEED_COMMENT',
        '유채원님이 댓글을 달았습니다',
        '유채원님: 이 커피 맛있어 보여요!',
        '/feed/13',
        NULL,
        FALSE,
        '2025-11-14 22:00:00',
        NULL
    ),
    (
        15,
        15,
        'SYSTEM',
        '계정 정지 알림',
        '이용 약관 위반으로 계정이 일시 정지되었습니다.',
        '/settings',
        NULL,
        TRUE,
        '2025-11-01 10:00:00',
        '2025-11-01 10:05:00'
    ) ON CONFLICT (notification_id) DO NOTHING;
-- ============================================================
-- LEVEL 3: References Level 0-2 — 2 tables
-- ============================================================
-- [27/44] vibe_prompts (15건, 1:1 with vibe_sessions)
INSERT INTO vibe_prompts (
        prompt_id,
        session_id,
        mood_keyword_ids,
        time_id,
        weather_id,
        place_id,
        companion_id,
        final_prompt,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        '[1, 3]',
        11,
        3,
        2,
        1,
        '저녁 비 오는 날, 카페에서 혼자 포근하고 나른한 무드의 콘텐츠를 추천해주세요.',
        '2025-11-01 10:01:00'
    ),
    (
        2,
        2,
        '[2, 11]',
        8,
        1,
        1,
        2,
        '오후 맑은 날, 집에서 연인과 몽글몽글하고 로맨틱한 무드를 즐기고 싶어요.',
        '2025-11-02 14:31:00'
    ),
    (
        3,
        3,
        '[9, 4]',
        3,
        13,
        3,
        1,
        '아침 온화한 날씨, 사무실에서 혼자 집중하며 청량한 무드를 원합니다.',
        '2025-11-03 09:16:00'
    ),
    (
        4,
        4,
        '[5, 7]',
        12,
        3,
        11,
        1,
        '밤 비 오는 날, 침실에서 혼자 쓸쓸하고 고요한 감성에 빠지고 싶어요.',
        '2025-11-04 20:01:00'
    ),
    (
        5,
        5,
        '[6, 14]',
        9,
        1,
        4,
        3,
        '오후 맑은 날, 공원에서 친구들과 활기차고 상쾌한 무드를 느끼고 싶어요.',
        '2025-11-05 16:46:00'
    ),
    (
        6,
        6,
        '[13, 1]',
        2,
        13,
        1,
        1,
        '이른 아침 온화한 날, 집에서 혼자 따뜻하고 포근한 아침 루틴을 즐기고 싶어요.',
        '2025-11-06 08:31:00'
    ),
    (
        7,
        7,
        '[12, 8]',
        13,
        2,
        12,
        10,
        '늦은 밤 흐린 날, 옥상에서 절친과 신비롭고 향수 어린 시간을 보내고 싶어요.',
        '2025-11-07 22:11:00'
    ),
    (
        8,
        8,
        '[1, 2]',
        4,
        8,
        2,
        1,
        '오전 이슬비 내리는 날, 카페에서 혼자 포근하고 몽글몽글한 무드를 원합니다.',
        '2025-11-08 11:21:00'
    ),
    (
        9,
        9,
        '[6, 9]',
        10,
        1,
        10,
        6,
        '늦은 오후 맑은 날, 작업실에서 동료와 활기차고 몰입되는 작업 무드를 원합니다.',
        '2025-11-09 15:01:00'
    ),
    (
        10,
        10,
        '[15, 7]',
        11,
        4,
        7,
        1,
        '저녁 눈 오는 날, 도서관에서 혼자 사색적이고 고요한 독서 무드를 즐기고 싶어요.',
        '2025-11-10 19:31:00'
    ),
    (
        11,
        11,
        '[4, 14]',
        2,
        1,
        5,
        5,
        '이른 아침 맑은 날, 해변에서 반려동물과 청량하고 상쾌한 산책을 즐기고 싶어요.',
        '2025-11-11 07:46:00'
    ),
    (
        12,
        12,
        '[10, 11]',
        6,
        13,
        1,
        4,
        '정오 온화한 날, 집에서 가족과 발랄하고 로맨틱한 분위기를 만들고 싶어요.',
        '2025-11-12 13:01:00'
    ),
    (
        13,
        13,
        '[5, 8]',
        12,
        3,
        11,
        1,
        '밤 비 오는 날, 침실에서 혼자 쓸쓸하고 향수 어린 영화 감상을 원합니다.',
        '2025-11-13 17:16:00'
    ),
    (
        14,
        14,
        '[11, 13]',
        11,
        1,
        8,
        2,
        '저녁 맑은 날, 레스토랑에서 연인과 로맨틱하고 따뜻한 데이트를 즐기고 싶어요.',
        '2025-11-14 21:31:00'
    ),
    (
        15,
        15,
        '[3, 15]',
        15,
        2,
        1,
        1,
        '심야 흐린 날, 집에서 혼자 나른하고 사색적인 새벽 감성을 즐기고 싶어요.',
        '2025-11-15 10:31:00'
    ) ON CONFLICT (session_id) DO NOTHING;
-- [28/44] archive_items (15건)
INSERT INTO archive_items (
        archive_item_id,
        user_id,
        item_id,
        reaction_id,
        memo,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        1,
        NULL,
        '기생충 정말 인상 깊었다',
        '2025-11-01 10:30:00'
    ),
    (
        2,
        2,
        16,
        NULL,
        '봄날은 언제 들어도 좋다',
        '2025-11-02 15:00:00'
    ),
    (
        3,
        3,
        31,
        NULL,
        '이 조명 조합 사무실에 적용해봐야지',
        '2025-11-03 09:30:00'
    ),
    (
        4,
        4,
        46,
        NULL,
        '멜로지오 캡슐 주문 완료',
        '2025-11-04 20:30:00'
    ),
    (
        5,
        5,
        6,
        NULL,
        '인터스텔라 다시 보고 싶다',
        '2025-11-05 17:00:00'
    ),
    (
        6,
        6,
        24,
        NULL,
        '좋은 날 아침마다 듣기 좋아',
        '2025-11-06 09:00:00'
    ),
    (
        7,
        7,
        34,
        NULL,
        '문라이트 블루 조명 예쁘다',
        '2025-11-07 22:30:00'
    ),
    (
        8,
        8,
        50,
        NULL,
        '아르페지오 진한 맛이 좋아',
        '2025-11-08 11:45:00'
    ),
    (
        9,
        9,
        8,
        NULL,
        '인셉션 명작 중의 명작',
        '2025-11-09 15:20:00'
    ),
    (
        10,
        10,
        22,
        NULL,
        'Ditto 중독성 있어',
        '2025-11-10 19:50:00'
    ),
    (
        11,
        11,
        35,
        NULL,
        '자연광 조명 공부할 때 최고',
        '2025-11-11 08:00:00'
    ),
    (
        12,
        12,
        55,
        NULL,
        '카자르 진짜 강렬하다',
        '2025-11-12 13:30:00'
    ),
    (
        13,
        13,
        5,
        NULL,
        '헤어질 결심 영상미가 대단해',
        '2025-11-13 17:30:00'
    ),
    (
        14,
        14,
        27,
        NULL,
        '보헤미안 랩소디 명곡',
        '2025-11-14 22:00:00'
    ),
    (
        15,
        15,
        39,
        NULL,
        '카페 분위기 조명 집에서 재현 성공',
        '2025-11-15 10:50:00'
    ) ON CONFLICT (user_id, item_id) DO NOTHING;
-- ============================================================
-- LEVEL 4: References Level 0-3 — 1 table
-- ============================================================
-- [29/44] vibe_results (15건, 1:1 with vibe_sessions)
INSERT INTO vibe_results (
        result_id,
        session_id,
        generated_image_url,
        phrase,
        ai_analysis,
        ai_model_version,
        processing_time_ms,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        'https://cdn.vibelink.com/vibe/result_001.jpg',
        '비 오는 저녁 카페 창가, 따뜻한 라떼 한 잔의 나른한 여유',
        '비 오는 저녁과 카페의 조합은 포근함과 나른함을 극대화합니다. 잔잔한 재즈 음악과 따뜻한 조명이 어울립니다.',
        'vibe-llm-v2.1',
        3200,
        '2025-11-01 10:05:00'
    ),
    (
        2,
        2,
        'https://cdn.vibelink.com/vibe/result_002.jpg',
        '햇살 가득한 오후, 거실 소파에서 연인과 함께하는 몽글몽글한 순간',
        '맑은 날씨와 편안한 공간에서의 로맨틱한 시간은 따뜻한 감성 영화와 달콤한 커피가 잘 어울립니다.',
        'vibe-llm-v2.1',
        2800,
        '2025-11-02 14:33:00'
    ),
    (
        3,
        3,
        'https://cdn.vibelink.com/vibe/result_003.jpg',
        '상쾌한 아침 사무실, 집중력을 높여주는 청량한 에너지',
        '온화한 날씨의 아침과 집중 모드의 조합은 깔끔한 커피와 밝은 자연광 조명이 최적입니다.',
        'vibe-llm-v2.1',
        2500,
        '2025-11-03 09:19:00'
    ),
    (
        4,
        4,
        'https://cdn.vibelink.com/vibe/result_004.jpg',
        '비 내리는 밤 침실, 고요한 적적함 속 깊은 사색의 시간',
        '비 오는 밤의 침실은 쓸쓸한 감성을 깊게 합니다. 잔잔한 발라드와 은은한 캔들 조명을 추천합니다.',
        'vibe-llm-v2.1',
        3100,
        '2025-11-04 20:04:00'
    ),
    (
        5,
        5,
        'https://cdn.vibelink.com/vibe/result_005.jpg',
        '맑은 오후 공원에서 친구들과 함께하는 활기찬 피크닉',
        '맑은 날씨의 공원에서 친구들과의 시간은 경쾌한 팝 음악과 상쾌한 음료가 어울립니다.',
        'vibe-llm-v2.1',
        2900,
        '2025-11-05 16:49:00'
    ),
    (
        6,
        6,
        'https://cdn.vibelink.com/vibe/result_006.jpg',
        '따뜻한 이른 아침, 집에서 시작하는 포근한 하루의 첫 순간',
        '온화한 아침의 집은 따뜻한 커피와 부드러운 조명으로 하루를 시작하기 좋습니다.',
        'vibe-llm-v2.1',
        2700,
        '2025-11-06 08:35:00'
    ),
    (
        7,
        7,
        'https://cdn.vibelink.com/vibe/result_007.jpg',
        '흐린 밤 옥상, 절친과 나누는 신비로운 추억 이야기',
        '흐린 밤 옥상에서의 대화는 감성적인 인디 음악과 은은한 간접조명이 분위기를 살립니다.',
        'vibe-llm-v2.1',
        3400,
        '2025-11-07 22:14:00'
    ),
    (
        8,
        8,
        'https://cdn.vibelink.com/vibe/result_008.jpg',
        '이슬비 내리는 오전 카페, 혼자만의 포근한 독서 시간',
        '이슬비와 카페의 조합은 따뜻한 음료와 잔잔한 BGM이 완벽하게 어울립니다.',
        'vibe-llm-v2.1',
        2600,
        '2025-11-08 11:24:00'
    ),
    (
        9,
        9,
        'https://cdn.vibelink.com/vibe/result_009.jpg',
        '맑은 늦은 오후 작업실, 동료와 함께하는 열정적인 창작 시간',
        '활기찬 에너지와 집중의 조합은 업템포 음악과 밝은 스튜디오 조명이 적합합니다.',
        'vibe-llm-v2.1',
        3000,
        '2025-11-09 15:04:00'
    ),
    (
        10,
        10,
        'https://cdn.vibelink.com/vibe/result_010.jpg',
        '눈 오는 저녁 도서관, 고요한 사색과 책 속으로의 여행',
        '눈 오는 저녁 도서관에서의 독서는 클래식 음악과 따뜻한 차가 완벽한 조합입니다.',
        'vibe-llm-v2.1',
        3300,
        '2025-11-10 19:35:00'
    ),
    (
        11,
        11,
        'https://cdn.vibelink.com/vibe/result_011.jpg',
        '이른 아침 해변, 반려견과 함께하는 청량한 산책',
        '맑은 아침 해변 산책은 경쾌한 어쿠스틱 기타 음악과 상쾌한 커피가 어울립니다.',
        'vibe-llm-v2.1',
        2400,
        '2025-11-11 07:50:00'
    ),
    (
        12,
        12,
        'https://cdn.vibelink.com/vibe/result_012.jpg',
        '온화한 정오 집에서, 가족과 만드는 발랄한 주말 브런치',
        '온화한 날씨의 정오에 가족과 함께하는 시간은 밝은 팝 음악과 따뜻한 조명이 좋습니다.',
        'vibe-llm-v2.1',
        2800,
        '2025-11-12 13:05:00'
    ),
    (
        13,
        13,
        'https://cdn.vibelink.com/vibe/result_013.jpg',
        '비 오는 밤 침실, 혼자 빠져드는 향수 어린 영화 감상',
        '비 오는 밤 영화 감상은 은은한 간접조명과 따뜻한 담요, 향기로운 커피가 필수입니다.',
        'vibe-llm-v2.1',
        3500,
        '2025-11-13 17:20:00'
    ),
    (
        14,
        14,
        'https://cdn.vibelink.com/vibe/result_014.jpg',
        '맑은 저녁 레스토랑, 연인과 함께하는 로맨틱한 디너',
        '맑은 저녁 레스토랑에서의 디너는 재즈 음악과 캔들 조명이 로맨틱한 분위기를 완성합니다.',
        'vibe-llm-v2.1',
        2900,
        '2025-11-14 21:35:00'
    ),
    (
        15,
        15,
        'https://cdn.vibelink.com/vibe/result_015.jpg',
        '흐린 심야 집, 나른한 사색 속 잔잔히 흐르는 새벽 감성',
        '심야의 집에서 혼자 보내는 시간은 잔잔한 앰비언트 음악과 은은한 촛불 조명이 어울립니다.',
        'vibe-llm-v2.1',
        3200,
        '2025-11-15 10:35:00'
    ) ON CONFLICT (session_id) DO NOTHING;
-- [30/44] vibe_items (15건)
INSERT INTO vibe_items (
        vibe_item_id,
        result_id,
        item_id,
        match_score,
        recommend_reason,
        is_user_liked,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        1,
        92.50,
        '비 오는 날 카페 분위기에 기생충의 긴장감 넘치는 스토리가 몰입감을 더합니다.',
        TRUE,
        '2025-11-01 10:05:00'
    ),
    (
        2,
        1,
        16,
        88.30,
        '봄날의 감성적인 멜로디가 나른한 카페 무드와 완벽히 어울립니다.',
        TRUE,
        '2025-11-01 10:05:00'
    ),
    (
        3,
        2,
        7,
        95.10,
        '라라랜드의 로맨틱한 분위기가 연인과의 시간에 완벽합니다.',
        TRUE,
        '2025-11-02 14:33:00'
    ),
    (
        4,
        2,
        31,
        85.70,
        '따뜻한 펜던트 조명이 거실의 로맨틱한 분위기를 만들어줍니다.',
        FALSE,
        '2025-11-02 14:33:00'
    ),
    (
        5,
        3,
        35,
        91.20,
        '밝은 자연광 조명이 집중력 높은 업무 환경을 만들어줍니다.',
        TRUE,
        '2025-11-03 09:19:00'
    ),
    (
        6,
        3,
        48,
        82.40,
        '로마 캡슐의 균형 잡힌 맛이 오전 업무 시작에 적합합니다.',
        TRUE,
        '2025-11-03 09:19:00'
    ),
    (
        7,
        4,
        26,
        94.80,
        'IU의 밤편지가 비 오는 밤 침실의 고요한 분위기에 완벽합니다.',
        TRUE,
        '2025-11-04 20:04:00'
    ),
    (
        8,
        5,
        17,
        89.60,
        'Dynamite의 활기찬 비트가 친구들과의 피크닉 무드를 올려줍니다.',
        TRUE,
        '2025-11-05 16:49:00'
    ),
    (
        9,
        6,
        46,
        90.30,
        '멜로지오의 부드러운 맛이 따뜻한 아침 루틴에 어울립니다.',
        TRUE,
        '2025-11-06 08:35:00'
    ),
    (
        10,
        7,
        22,
        87.50,
        'Ditto의 레트로 감성이 옥상에서의 추억 이야기와 잘 맞습니다.',
        FALSE,
        '2025-11-07 22:14:00'
    ),
    (
        11,
        8,
        39,
        93.10,
        '카페 앰비언트 조명이 이슬비 내리는 날의 카페 무드를 완성합니다.',
        TRUE,
        '2025-11-08 11:24:00'
    ),
    (
        12,
        9,
        40,
        86.80,
        '밝은 스튜디오 조명이 창작 작업의 집중력을 높여줍니다.',
        TRUE,
        '2025-11-09 15:04:00'
    ),
    (
        13,
        10,
        30,
        91.70,
        'Hotel California의 클래식한 무드가 독서 시간에 어울립니다.',
        TRUE,
        '2025-11-10 19:35:00'
    ),
    (
        14,
        11,
        20,
        88.90,
        'Super Shy의 경쾌한 멜로디가 해변 산책 무드를 올려줍니다.',
        FALSE,
        '2025-11-11 07:50:00'
    ),
    (
        15,
        13,
        33,
        92.00,
        '캔들 조명의 은은한 빛이 감성적인 영화 감상 분위기를 만듭니다.',
        TRUE,
        '2025-11-13 17:20:00'
    ) ON CONFLICT (result_id, item_id) DO NOTHING;
-- [31/44] archive_vibes (15건)
INSERT INTO archive_vibes (
        archive_id,
        user_id,
        result_id,
        folder_id,
        memo,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        1,
        1,
        '비 오는 날 카페 무드 저장',
        '2025-11-01 10:30:00'
    ),
    (
        2,
        2,
        2,
        2,
        '연인과의 오후 감성',
        '2025-11-02 15:00:00'
    ),
    (
        3,
        3,
        3,
        5,
        '업무 집중 모드 세팅 완료',
        '2025-11-03 09:30:00'
    ),
    (
        4,
        4,
        4,
        4,
        '비 오는 밤 힐링',
        '2025-11-04 20:30:00'
    ),
    (
        5,
        5,
        5,
        NULL,
        '친구들과 피크닉 기록',
        '2025-11-05 17:00:00'
    ),
    (
        6,
        6,
        6,
        6,
        '포근한 아침 루틴 저장',
        '2025-11-06 09:00:00'
    ),
    (
        7,
        7,
        7,
        7,
        '옥상에서의 밤 산책 무드',
        '2025-11-07 22:30:00'
    ),
    (
        8,
        8,
        8,
        8,
        '이슬비 카페 분위기 최고',
        '2025-11-08 11:45:00'
    ),
    (
        9,
        9,
        9,
        NULL,
        '작업실 창작 에너지 충전',
        '2025-11-09 15:20:00'
    ),
    (
        10,
        10,
        10,
        10,
        '눈 오는 날 도서관 독서 무드',
        '2025-11-10 19:50:00'
    ),
    (
        11,
        11,
        11,
        11,
        '해변 산책 상쾌했다',
        '2025-11-11 08:00:00'
    ),
    (
        12,
        12,
        12,
        12,
        '가족 브런치 분위기 좋았어',
        '2025-11-12 13:30:00'
    ),
    (
        13,
        13,
        13,
        13,
        '혼자 영화 보는 밤 감성',
        '2025-11-13 17:45:00'
    ),
    (
        14,
        14,
        14,
        14,
        '레스토랑 데이트 완벽했다',
        '2025-11-14 22:00:00'
    ),
    (
        15,
        15,
        15,
        15,
        '새벽 감성 최고의 순간',
        '2025-11-15 11:00:00'
    ) ON CONFLICT (user_id, result_id) DO NOTHING;
-- [32/44] feeds (15건)
INSERT INTO feeds (
        feed_id,
        user_id,
        result_id,
        caption,
        is_public,
        is_pinned,
        view_count,
        created_at,
        updated_at,
        deleted_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        1,
        '비 오는 저녁 카페에서 나른하게 보낸 시간. 기생충 다시 보면서 라떼 한 잔.',
        TRUE,
        FALSE,
        156,
        '2025-11-01 11:00:00',
        '2025-11-01 11:00:00',
        NULL
    ),
    (
        2,
        2,
        2,
        '햇살 좋은 오후, 연인과 거실에서 라라랜드 보는 중. 이런 게 행복이지.',
        TRUE,
        TRUE,
        243,
        '2025-11-02 15:30:00',
        '2025-11-02 15:30:00',
        NULL
    ),
    (
        3,
        3,
        3,
        '오전부터 집중 모드 ON. 자연광 조명이랑 로마 캡슐이면 완벽한 업무 환경 완성.',
        TRUE,
        FALSE,
        89,
        '2025-11-03 10:00:00',
        '2025-11-03 10:00:00',
        NULL
    ),
    (
        4,
        4,
        4,
        '비 오는 밤, 침실에서 혼자. IU 밤편지 들으면서 생각에 잠기는 밤.',
        TRUE,
        FALSE,
        312,
        '2025-11-04 21:00:00',
        '2025-11-04 21:00:00',
        NULL
    ),
    (
        5,
        5,
        5,
        '친구들이랑 공원 피크닉! Dynamite 틀어놓고 신나게 놀았다.',
        TRUE,
        FALSE,
        178,
        '2025-11-05 18:00:00',
        '2025-11-05 18:00:00',
        NULL
    ),
    (
        6,
        6,
        6,
        '따뜻한 아침 루틴. 멜로지오 한 잔으로 하루를 시작하는 포근한 순간.',
        TRUE,
        TRUE,
        201,
        '2025-11-06 09:30:00',
        '2025-11-06 09:30:00',
        NULL
    ),
    (
        7,
        7,
        7,
        '흐린 밤 옥상에서 절친과 나눈 이야기. Ditto 들으면서 추억 소환.',
        FALSE,
        FALSE,
        45,
        '2025-11-07 23:00:00',
        '2025-11-07 23:00:00',
        NULL
    ),
    (
        8,
        8,
        8,
        '이슬비 내리는 날, 카페 창가 자리 득템. 포근한 조명 아래 독서 타임.',
        TRUE,
        FALSE,
        134,
        '2025-11-08 12:00:00',
        '2025-11-08 12:00:00',
        NULL
    ),
    (
        9,
        9,
        9,
        '동료랑 작업실에서 밤새 작업 중. 스튜디오 조명 풀파워!',
        TRUE,
        FALSE,
        67,
        '2025-11-09 16:00:00',
        '2025-11-09 16:00:00',
        NULL
    ),
    (
        10,
        10,
        10,
        '눈 오는 저녁 도서관에서 Hotel California 들으며 독서. 완벽한 조합.',
        TRUE,
        FALSE,
        198,
        '2025-11-10 20:30:00',
        '2025-11-10 20:30:00',
        NULL
    ),
    (
        11,
        11,
        11,
        '이른 아침 해변 산책, 반려견과 함께. Super Shy 들으면서 걷기 최고.',
        TRUE,
        FALSE,
        256,
        '2025-11-11 08:30:00',
        '2025-11-11 08:30:00',
        NULL
    ),
    (
        12,
        12,
        12,
        '가족이랑 브런치 만들면서 들은 음악들. 주말의 여유.',
        FALSE,
        FALSE,
        23,
        '2025-11-12 14:00:00',
        '2025-11-12 14:00:00',
        NULL
    ),
    (
        13,
        13,
        13,
        '비 오는 밤 혼자 영화 보기. 캔들 조명 켜놓으니 분위기 대박.',
        TRUE,
        TRUE,
        345,
        '2025-11-13 18:00:00',
        '2025-11-13 18:00:00',
        NULL
    ),
    (
        14,
        14,
        14,
        '연인과 레스토랑 디너. 재즈 음악에 캔들 조명, 완벽한 저녁.',
        TRUE,
        FALSE,
        287,
        '2025-11-14 22:30:00',
        '2025-11-14 22:30:00',
        NULL
    ),
    (
        15,
        15,
        15,
        '새벽 2시, 혼자 앰비언트 음악 들으며 사색하는 시간. 이런 고요함이 좋다.',
        FALSE,
        FALSE,
        12,
        '2025-11-15 11:30:00',
        '2025-11-15 11:30:00',
        NULL
    ) ON CONFLICT (feed_id) DO NOTHING;
-- ============================================================
-- LEVEL 6: References Level 0-5 — 3 tables
-- ============================================================
-- [33/44] feed_reactions (15건)
INSERT INTO feed_reactions (
        reaction_id,
        feed_id,
        user_id,
        reaction_type,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (1, 1, 2, 'LIKE', '2025-11-01 12:00:00'),
    (2, 1, 3, 'LOVE', '2025-11-01 13:00:00'),
    (3, 2, 1, 'LIKE', '2025-11-02 16:00:00'),
    (4, 2, 4, 'WOW', '2025-11-02 17:00:00'),
    (5, 3, 1, 'COZY', '2025-11-03 11:00:00'),
    (6, 3, 5, 'LIKE', '2025-11-03 12:00:00'),
    (7, 4, 2, 'LOVE', '2025-11-04 22:00:00'),
    (8, 4, 6, 'LIKE', '2025-11-04 23:00:00'),
    (9, 5, 3, 'WOW', '2025-11-05 19:00:00'),
    (10, 5, 7, 'LIKE', '2025-11-05 20:00:00'),
    (11, 6, 1, 'LOVE', '2025-11-06 10:00:00'),
    (12, 8, 9, 'COZY', '2025-11-08 13:00:00'),
    (13, 10, 4, 'LIKE', '2025-11-10 21:00:00'),
    (14, 11, 6, 'LOVE', '2025-11-11 09:00:00'),
    (15, 13, 8, 'LIKE', '2025-11-13 19:00:00') ON CONFLICT (feed_id, user_id, reaction_type) DO NOTHING;
-- [34/44] feed_comments (15건)
INSERT INTO feed_comments (
        comment_id,
        feed_id,
        user_id,
        parent_comment_id,
        content,
        is_hidden,
        created_at,
        updated_at,
        deleted_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        2,
        NULL,
        '분위기 좋네요! 저도 비 오는 날 카페 가고 싶어요.',
        FALSE,
        '2025-11-01 12:30:00',
        '2025-11-01 12:30:00',
        NULL
    ),
    (
        2,
        1,
        3,
        NULL,
        '기생충 정말 명작이죠. 카페 어디예요?',
        FALSE,
        '2025-11-01 13:00:00',
        '2025-11-01 13:00:00',
        NULL
    ),
    (
        3,
        2,
        1,
        NULL,
        '라라랜드 보면서 데이트 부러워요ㅠ',
        FALSE,
        '2025-11-02 16:30:00',
        '2025-11-02 16:30:00',
        NULL
    ),
    (
        4,
        2,
        4,
        NULL,
        '거실 인테리어 너무 예뻐요! 조명 정보 좀 알려주세요.',
        FALSE,
        '2025-11-02 17:30:00',
        '2025-11-02 17:30:00',
        NULL
    ),
    (
        5,
        3,
        5,
        NULL,
        '집중 모드 세팅 좋네요. 저도 따라해봐야겠어요.',
        FALSE,
        '2025-11-03 11:30:00',
        '2025-11-03 11:30:00',
        NULL
    ),
    (
        6,
        4,
        6,
        NULL,
        '밤편지 들으면 왜 항상 감성에 젖게 되는지... 공감해요.',
        FALSE,
        '2025-11-04 22:30:00',
        '2025-11-04 22:30:00',
        NULL
    ),
    (
        7,
        5,
        7,
        NULL,
        '친구들이랑 피크닉 재밌어 보여요! 장소가 어디예요?',
        FALSE,
        '2025-11-05 19:30:00',
        '2025-11-05 19:30:00',
        NULL
    ),
    (
        8,
        6,
        8,
        NULL,
        '멜로지오 저도 좋아해요. 아침에 딱이에요.',
        FALSE,
        '2025-11-06 10:30:00',
        '2025-11-06 10:30:00',
        NULL
    ),
    (
        9,
        8,
        9,
        NULL,
        '이슬비 내리는 카페 창가... 그림 같은 풍경이네요.',
        FALSE,
        '2025-11-08 13:30:00',
        '2025-11-08 13:30:00',
        NULL
    ),
    (
        10,
        10,
        5,
        NULL,
        'Hotel California 도서관에서 들으면 진짜 분위기 있겠다.',
        FALSE,
        '2025-11-10 21:30:00',
        '2025-11-10 21:30:00',
        NULL
    ),
    -- 대댓글 (parent_comment_id 참조)
    (
        11,
        1,
        1,
        1,
        '감사합니다! 연남동 카페거리에 있는 곳이에요.',
        FALSE,
        '2025-11-01 14:00:00',
        '2025-11-01 14:00:00',
        NULL
    ),
    (
        12,
        1,
        1,
        2,
        '네! 볼 때마다 새로운 매력이 있어요. 카페는 연남동이에요.',
        FALSE,
        '2025-11-01 14:05:00',
        '2025-11-01 14:05:00',
        NULL
    ),
    (
        13,
        2,
        2,
        4,
        '조명은 필립스 휴 펜던트 조명이에요! 추천합니다.',
        FALSE,
        '2025-11-02 18:00:00',
        '2025-11-02 18:00:00',
        NULL
    ),
    (
        14,
        5,
        5,
        7,
        '여의도 한강공원이에요! 주말에 강추.',
        FALSE,
        '2025-11-05 20:30:00',
        '2025-11-05 20:30:00',
        NULL
    ),
    (
        15,
        6,
        6,
        8,
        '맞아요! 부드럽고 달콤해서 아침에 최고예요.',
        FALSE,
        '2025-11-06 11:00:00',
        '2025-11-06 11:00:00',
        NULL
    ) ON CONFLICT (comment_id) DO NOTHING;
-- [35/44] favorites (15건)
INSERT INTO favorites (favorite_id, user_id, archive_id, created_at) OVERRIDING SYSTEM VALUE
VALUES (1, 1, 1, '2025-11-01 11:00:00'),
    (2, 2, 2, '2025-11-02 16:00:00'),
    (3, 3, 3, '2025-11-03 10:00:00'),
    (4, 4, 4, '2025-11-04 21:00:00'),
    (5, 5, 5, '2025-11-05 18:00:00'),
    (6, 6, 6, '2025-11-06 09:30:00'),
    (7, 7, 7, '2025-11-07 23:00:00'),
    (8, 8, 8, '2025-11-08 12:00:00'),
    (9, 9, 9, '2025-11-09 16:00:00'),
    (10, 10, 10, '2025-11-10 20:00:00'),
    (11, 11, 11, '2025-11-11 08:30:00'),
    (12, 12, 12, '2025-11-12 14:00:00'),
    (13, 13, 13, '2025-11-13 18:00:00'),
    (14, 14, 14, '2025-11-14 23:00:00'),
    (15, 15, 15, '2025-11-15 11:30:00') ON CONFLICT (user_id, archive_id) DO NOTHING;
-- ============================================================
-- LEVEL 7: References Level 0-6 — 1 table
-- ============================================================
-- [36/44] comment_reactions (15건)
INSERT INTO comment_reactions (reaction_id, comment_id, user_id, created_at) OVERRIDING SYSTEM VALUE
VALUES (1, 1, 3, '2025-11-01 13:30:00'),
    (2, 2, 4, '2025-11-01 14:30:00'),
    (3, 3, 5, '2025-11-02 17:00:00'),
    (4, 4, 6, '2025-11-02 18:30:00'),
    (5, 5, 7, '2025-11-03 12:00:00'),
    (6, 6, 8, '2025-11-04 23:00:00'),
    (7, 7, 9, '2025-11-05 20:00:00'),
    (8, 8, 10, '2025-11-06 11:00:00'),
    (9, 9, 11, '2025-11-08 14:00:00'),
    (10, 10, 12, '2025-11-10 22:00:00'),
    (11, 11, 2, '2025-11-01 15:00:00'),
    (12, 12, 3, '2025-11-01 15:30:00'),
    (13, 13, 1, '2025-11-02 19:00:00'),
    (14, 14, 3, '2025-11-05 21:00:00'),
    (15, 15, 8, '2025-11-06 12:00:00') ON CONFLICT (comment_id, user_id) DO NOTHING;
-- ============================================================
-- 비MVP / Deferred Tables — 8 tables
-- ============================================================
-- [37/44] reports (15건)
INSERT INTO reports (
        report_id,
        user_id,
        report_type,
        year,
        month,
        total_vibes,
        active_days,
        top_mood_keyword_id,
        top_time_id,
        top_place_id,
        mood_distribution,
        time_distribution,
        weekly_trend,
        recommended_items,
        identity_type,
        identity_emoji,
        report_image_url,
        share_card_url,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        'MONTHLY',
        2025,
        11,
        8,
        15,
        1,
        11,
        2,
        '{"cozy":4,"languid":3,"dreamy":1}',
        '{"evening":5,"afternoon":2,"night":1}',
        '[2,3,1,2]',
        '[1,16,31]',
        '감성 카페러',
        NULL,
        'https://cdn.vibelink.com/report/1.jpg',
        'https://cdn.vibelink.com/share/1.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        2,
        2,
        'MONTHLY',
        2025,
        11,
        6,
        12,
        11,
        8,
        1,
        '{"romantic":3,"dreamy":2,"warm":1}',
        '{"afternoon":4,"evening":2}',
        '[1,2,1,2]',
        '[7,46,31]',
        '로맨틱 드리머',
        NULL,
        'https://cdn.vibelink.com/report/2.jpg',
        'https://cdn.vibelink.com/share/2.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        3,
        3,
        'MONTHLY',
        2025,
        11,
        10,
        20,
        9,
        3,
        3,
        '{"focused":5,"crisp":3,"energetic":2}',
        '{"morning":6,"mid_morning":3,"noon":1}',
        '[3,2,3,2]',
        '[35,48,40]',
        '몰입형 워커',
        NULL,
        'https://cdn.vibelink.com/report/3.jpg',
        'https://cdn.vibelink.com/share/3.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        4,
        4,
        'MONTHLY',
        2025,
        11,
        5,
        10,
        5,
        12,
        11,
        '{"melancholic":3,"serene":2}',
        '{"night":4,"late_night":1}',
        '[1,1,2,1]',
        '[26,33,47]',
        '감성 은둔자',
        NULL,
        'https://cdn.vibelink.com/report/4.jpg',
        'https://cdn.vibelink.com/share/4.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        5,
        5,
        'MONTHLY',
        2025,
        11,
        7,
        14,
        6,
        9,
        4,
        '{"energetic":4,"refreshing":2,"crisp":1}',
        '{"mid_afternoon":3,"afternoon":2,"evening":2}',
        '[2,1,2,2]',
        '[17,20,21]',
        '에너지 넘치는 탐험가',
        NULL,
        'https://cdn.vibelink.com/report/5.jpg',
        'https://cdn.vibelink.com/share/5.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        6,
        6,
        'MONTHLY',
        2025,
        11,
        4,
        8,
        13,
        2,
        1,
        '{"warm":3,"cozy":1}',
        '{"early_morning":3,"morning":1}',
        '[1,1,1,1]',
        '[46,24,44]',
        '따뜻한 아침형 인간',
        NULL,
        'https://cdn.vibelink.com/report/6.jpg',
        'https://cdn.vibelink.com/share/6.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        7,
        7,
        'MONTHLY',
        2025,
        11,
        3,
        6,
        12,
        13,
        12,
        '{"mysterious":2,"nostalgic":1}',
        '{"late_night":2,"night":1}',
        '[1,0,1,1]',
        '[22,34,38]',
        '밤의 탐험가',
        NULL,
        'https://cdn.vibelink.com/report/7.jpg',
        'https://cdn.vibelink.com/share/7.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        8,
        8,
        'MONTHLY',
        2025,
        11,
        9,
        18,
        1,
        4,
        2,
        '{"cozy":5,"dreamy":3,"warm":1}',
        '{"mid_morning":4,"afternoon":3,"evening":2}',
        '[2,3,2,2]',
        '[39,50,26]',
        '카페 감성러',
        NULL,
        'https://cdn.vibelink.com/report/8.jpg',
        'https://cdn.vibelink.com/share/8.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        9,
        9,
        'MONTHLY',
        2025,
        11,
        6,
        12,
        6,
        10,
        10,
        '{"energetic":3,"focused":2,"crisp":1}',
        '{"late_afternoon":3,"afternoon":2,"evening":1}',
        '[2,1,2,1]',
        '[40,48,17]',
        '열정적 크리에이터',
        NULL,
        'https://cdn.vibelink.com/report/9.jpg',
        'https://cdn.vibelink.com/share/9.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        10,
        10,
        'MONTHLY',
        2025,
        11,
        5,
        10,
        15,
        11,
        7,
        '{"contemplative":3,"serene":2}',
        '{"evening":3,"night":2}',
        '[1,1,2,1]',
        '[30,10,35]',
        '사색하는 독서가',
        NULL,
        'https://cdn.vibelink.com/report/10.jpg',
        'https://cdn.vibelink.com/share/10.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        11,
        11,
        'MONTHLY',
        2025,
        11,
        4,
        8,
        4,
        2,
        5,
        '{"crisp":2,"refreshing":2}',
        '{"early_morning":3,"morning":1}',
        '[1,1,1,1]',
        '[20,35,51]',
        '새벽 산책러',
        NULL,
        'https://cdn.vibelink.com/report/11.jpg',
        'https://cdn.vibelink.com/share/11.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        12,
        12,
        'MONTHLY',
        2025,
        11,
        2,
        4,
        10,
        6,
        1,
        '{"whimsical":1,"romantic":1}',
        '{"noon":2}',
        '[0,1,1,0]',
        '[46,31,7]',
        '주말 미식가',
        NULL,
        'https://cdn.vibelink.com/report/12.jpg',
        'https://cdn.vibelink.com/share/12.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        13,
        13,
        'MONTHLY',
        2025,
        11,
        7,
        14,
        5,
        12,
        11,
        '{"melancholic":4,"nostalgic":2,"warm":1}',
        '{"night":4,"late_night":2,"evening":1}',
        '[2,1,2,2]',
        '[26,33,5]',
        '감성 영화 매니아',
        NULL,
        'https://cdn.vibelink.com/report/13.jpg',
        'https://cdn.vibelink.com/share/13.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        14,
        14,
        'MONTHLY',
        2025,
        11,
        3,
        6,
        11,
        11,
        8,
        '{"romantic":2,"warm":1}',
        '{"evening":3}',
        '[1,0,1,1]',
        '[7,33,47]',
        '로맨틱 미식가',
        NULL,
        'https://cdn.vibelink.com/report/14.jpg',
        'https://cdn.vibelink.com/share/14.jpg',
        '2025-12-01 09:00:00'
    ),
    (
        15,
        1,
        'YEARLY',
        2025,
        NULL,
        52,
        120,
        1,
        11,
        2,
        '{"cozy":20,"languid":12,"dreamy":8,"warm":6,"focused":6}',
        '{"evening":22,"afternoon":15,"night":8,"morning":7}',
        '[12,14,13,13]',
        '[1,16,31,46]',
        '감성 탐험가',
        NULL,
        'https://cdn.vibelink.com/report/15.jpg',
        'https://cdn.vibelink.com/share/15.jpg',
        '2025-12-31 09:00:00'
    ) ON CONFLICT (user_id, report_type, year, month) DO NOTHING;
-- [38/44] external_connections (15건)
INSERT INTO external_connections (
        connection_id,
        user_id,
        service_type,
        access_token,
        refresh_token,
        token_expires_at,
        service_user_id,
        service_user_name,
        is_active,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        'SPOTIFY',
        'sp_at_001',
        'sp_rt_001',
        '2026-06-01 00:00:00',
        'sp_user_001',
        '민준의Spotify',
        TRUE,
        '2025-08-01 10:00:00',
        '2025-08-01 10:00:00'
    ),
    (
        2,
        2,
        'NETFLIX',
        'nf_at_002',
        'nf_rt_002',
        '2026-06-05 00:00:00',
        'nf_user_002',
        '서연Netflix',
        TRUE,
        '2025-08-05 11:00:00',
        '2025-08-05 11:00:00'
    ),
    (
        3,
        3,
        'HUE',
        'hue_at_03',
        'hue_rt_03',
        '2026-06-10 00:00:00',
        'hue_user_003',
        '지호의Hue',
        TRUE,
        '2025-08-10 09:00:00',
        '2025-08-10 09:00:00'
    ),
    (
        4,
        4,
        'SPOTIFY',
        'sp_at_004',
        'sp_rt_004',
        '2026-07-01 00:00:00',
        'sp_user_004',
        '수아Spotify',
        TRUE,
        '2025-08-15 15:00:00',
        '2025-08-15 15:00:00'
    ),
    (
        5,
        5,
        'SPOTIFY',
        'sp_at_005',
        'sp_rt_005',
        '2026-07-15 00:00:00',
        'sp_user_005',
        '도윤Spotify',
        TRUE,
        '2025-09-01 08:00:00',
        '2025-09-01 08:00:00'
    ),
    (
        6,
        6,
        'NETFLIX',
        'nf_at_006',
        'nf_rt_006',
        '2026-07-20 00:00:00',
        'nf_user_006',
        '예린Netflix',
        TRUE,
        '2025-09-05 12:00:00',
        '2025-09-05 12:00:00'
    ),
    (
        7,
        7,
        'HUE',
        'hue_at_07',
        'hue_rt_07',
        '2026-08-01 00:00:00',
        'hue_user_007',
        '하준Hue',
        TRUE,
        '2025-09-10 10:00:00',
        '2025-09-10 10:00:00'
    ),
    (
        8,
        8,
        'SPOTIFY',
        'sp_at_008',
        'sp_rt_008',
        '2026-08-10 00:00:00',
        'sp_user_008',
        '지은Spotify',
        TRUE,
        '2025-09-15 14:00:00',
        '2025-09-15 14:00:00'
    ),
    (
        9,
        9,
        'HUE',
        'hue_at_09',
        'hue_rt_09',
        '2026-08-20 00:00:00',
        'hue_user_009',
        '태현Hue',
        TRUE,
        '2025-09-20 09:00:00',
        '2025-09-20 09:00:00'
    ),
    (
        10,
        10,
        'SPOTIFY',
        'sp_at_010',
        'sp_rt_010',
        '2026-09-01 00:00:00',
        'sp_user_010',
        '수빈Spotify',
        TRUE,
        '2025-10-01 11:00:00',
        '2025-10-01 11:00:00'
    ),
    (
        11,
        11,
        'NETFLIX',
        'nf_at_011',
        'nf_rt_011',
        '2026-09-10 00:00:00',
        'nf_user_011',
        '준우Netflix',
        FALSE,
        '2025-10-05 16:00:00',
        '2025-11-01 10:00:00'
    ),
    (
        12,
        12,
        'SPOTIFY',
        'sp_at_012',
        'sp_rt_012',
        '2026-09-15 00:00:00',
        'sp_user_012',
        '하은Spotify',
        FALSE,
        '2025-10-10 13:00:00',
        '2025-10-15 12:00:00'
    ),
    (
        13,
        13,
        'HUE',
        'hue_at_13',
        'hue_rt_13',
        '2026-10-01 00:00:00',
        'hue_user_013',
        '민서Hue',
        TRUE,
        '2025-10-15 10:00:00',
        '2025-10-15 10:00:00'
    ),
    (
        14,
        14,
        'NETFLIX',
        'nf_at_014',
        'nf_rt_014',
        '2026-10-10 00:00:00',
        'nf_user_014',
        '채원Netflix',
        TRUE,
        '2025-10-20 08:00:00',
        '2025-10-20 08:00:00'
    ),
    (
        15,
        15,
        'SPOTIFY',
        'sp_at_015',
        'sp_rt_015',
        '2026-10-20 00:00:00',
        'sp_user_015',
        '은호Spotify',
        FALSE,
        '2025-10-25 14:00:00',
        '2025-11-01 10:00:00'
    ) ON CONFLICT (user_id, service_type) DO NOTHING;
-- [39/44] search_histories (15건)
INSERT INTO search_histories (
        history_id,
        user_id,
        search_type,
        keyword,
        session_id,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        'VIBE',
        '비 오는 날 카페',
        1,
        '2025-11-01 09:50:00'
    ),
    (
        2,
        2,
        'VIBE',
        '로맨틱한 오후',
        2,
        '2025-11-02 14:20:00'
    ),
    (
        3,
        3,
        'ITEM',
        '자연광 조명',
        NULL,
        '2025-11-03 09:00:00'
    ),
    (
        4,
        4,
        'VIBE',
        '쓸쓸한 밤',
        4,
        '2025-11-04 19:50:00'
    ),
    (
        5,
        5,
        'FEED',
        '피크닉',
        NULL,
        '2025-11-05 16:30:00'
    ),
    (
        6,
        6,
        'ITEM',
        '네스프레소 멜로지오',
        NULL,
        '2025-11-06 08:20:00'
    ),
    (
        7,
        7,
        'USER',
        '절친',
        NULL,
        '2025-11-07 22:00:00'
    ),
    (
        8,
        8,
        'VIBE',
        '이슬비 카페',
        8,
        '2025-11-08 11:10:00'
    ),
    (
        9,
        9,
        'ITEM',
        '스튜디오 조명',
        NULL,
        '2025-11-09 14:50:00'
    ),
    (
        10,
        10,
        'VIBE',
        '눈 오는 저녁',
        10,
        '2025-11-10 19:20:00'
    ),
    (
        11,
        11,
        'FEED',
        '해변 산책',
        NULL,
        '2025-11-11 07:30:00'
    ),
    (
        12,
        12,
        'ITEM',
        '브런치 레시피',
        NULL,
        '2025-11-12 12:50:00'
    ),
    (
        13,
        13,
        'VIBE',
        '혼자 영화 보기',
        13,
        '2025-11-13 17:00:00'
    ),
    (
        14,
        14,
        'FEED',
        '데이트 레스토랑',
        NULL,
        '2025-11-14 21:20:00'
    ),
    (
        15,
        15,
        'VIBE',
        '새벽 감성',
        15,
        '2025-11-15 10:20:00'
    ) ON CONFLICT (history_id) DO NOTHING;
-- [40/44] trending_vibes (15건)
INSERT INTO trending_vibes (
        trend_id,
        result_id,
        score,
        rank_position,
        trend_date,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        13,
        985.50,
        1,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        2,
        4,
        872.30,
        2,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        3,
        2,
        768.90,
        3,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        4,
        11,
        654.20,
        4,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        5,
        14,
        612.80,
        5,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        6,
        1,
        589.40,
        6,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        7,
        6,
        534.10,
        7,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        8,
        10,
        498.70,
        8,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        9,
        8,
        445.30,
        9,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        10,
        5,
        412.60,
        10,
        '2025-11-15',
        '2025-11-15 09:00:00'
    ),
    (
        11,
        1,
        920.10,
        1,
        '2025-11-14',
        '2025-11-14 09:00:00'
    ),
    (
        12,
        4,
        845.70,
        2,
        '2025-11-14',
        '2025-11-14 09:00:00'
    ),
    (
        13,
        2,
        732.40,
        3,
        '2025-11-14',
        '2025-11-14 09:00:00'
    ),
    (
        14,
        11,
        698.50,
        4,
        '2025-11-14',
        '2025-11-14 09:00:00'
    ),
    (
        15,
        6,
        654.20,
        5,
        '2025-11-14',
        '2025-11-14 09:00:00'
    ) ON CONFLICT (result_id, trend_date) DO NOTHING;
-- [41/44] mood_trends (15건)
INSERT INTO mood_trends (
        trend_id,
        keyword_id,
        trend_date,
        usage_count,
        growth_rate,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        '2025-11-15',
        245,
        12.50,
        '2025-11-15 09:00:00'
    ),
    (
        2,
        5,
        '2025-11-15',
        198,
        8.30,
        '2025-11-15 09:00:00'
    ),
    (
        3,
        11,
        '2025-11-15',
        176,
        15.20,
        '2025-11-15 09:00:00'
    ),
    (
        4,
        6,
        '2025-11-15',
        156,
        -3.40,
        '2025-11-15 09:00:00'
    ),
    (
        5,
        9,
        '2025-11-15',
        134,
        5.10,
        '2025-11-15 09:00:00'
    ),
    (
        6,
        2,
        '2025-11-15',
        121,
        7.80,
        '2025-11-15 09:00:00'
    ),
    (
        7,
        7,
        '2025-11-15',
        98,
        -1.20,
        '2025-11-15 09:00:00'
    ),
    (
        8,
        13,
        '2025-11-15',
        87,
        22.30,
        '2025-11-15 09:00:00'
    ),
    (
        9,
        1,
        '2025-11-14',
        218,
        10.10,
        '2025-11-14 09:00:00'
    ),
    (
        10,
        5,
        '2025-11-14',
        183,
        6.50,
        '2025-11-14 09:00:00'
    ),
    (
        11,
        11,
        '2025-11-14',
        153,
        11.40,
        '2025-11-14 09:00:00'
    ),
    (
        12,
        6,
        '2025-11-14',
        161,
        4.20,
        '2025-11-14 09:00:00'
    ),
    (
        13,
        9,
        '2025-11-14',
        128,
        3.80,
        '2025-11-14 09:00:00'
    ),
    (
        14,
        8,
        '2025-11-14',
        112,
        9.60,
        '2025-11-14 09:00:00'
    ),
    (
        15,
        15,
        '2025-11-14',
        95,
        18.70,
        '2025-11-14 09:00:00'
    ) ON CONFLICT (keyword_id, trend_date) DO NOTHING;
-- [42/44] etl_job_logs (15건)
INSERT INTO etl_job_logs (
        id,
        job_name,
        dag_id,
        task_id,
        domain,
        pipeline_stage,
        execution_date,
        status,
        records_processed,
        records_failed,
        records_skipped,
        started_at,
        completed_at,
        error_message,
        metadata,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        'movie_collect',
        'dag_movie_etl',
        'task_tmdb_fetch',
        'video',
        'COLLECT',
        '2025-11-01 02:00:00',
        'SUCCESS',
        150,
        0,
        5,
        '2025-11-01 02:00:00',
        '2025-11-01 02:15:00',
        NULL,
        '{"source":"TMDB","api_version":"3"}',
        '2025-11-01 02:00:00'
    ),
    (
        2,
        'movie_graph_process',
        'dag_movie_etl',
        'task_neo4j_sync',
        'video',
        'GRAPH_PROCESS',
        '2025-11-01 03:00:00',
        'SUCCESS',
        150,
        2,
        0,
        '2025-11-01 03:00:00',
        '2025-11-01 03:30:00',
        NULL,
        '{"neo4j_version":"5.x"}',
        '2025-11-01 03:00:00'
    ),
    (
        3,
        'music_collect',
        'dag_music_etl',
        'task_musicbrainz_fetch',
        'music',
        'COLLECT',
        '2025-11-01 04:00:00',
        'SUCCESS',
        200,
        3,
        10,
        '2025-11-01 04:00:00',
        '2025-11-01 04:25:00',
        NULL,
        '{"source":"MusicBrainz","batch_size":50}',
        '2025-11-01 04:00:00'
    ),
    (
        4,
        'music_graph_process',
        'dag_music_etl',
        'task_neo4j_sync',
        'music',
        'GRAPH_PROCESS',
        '2025-11-01 05:00:00',
        'SUCCESS',
        197,
        0,
        0,
        '2025-11-01 05:00:00',
        '2025-11-01 05:20:00',
        NULL,
        '{"neo4j_version":"5.x"}',
        '2025-11-01 05:00:00'
    ),
    (
        5,
        'coffee_collect',
        'dag_coffee_etl',
        'task_nespresso_scrape',
        'coffee',
        'COLLECT',
        '2025-11-01 06:00:00',
        'SUCCESS',
        60,
        0,
        2,
        '2025-11-01 06:00:00',
        '2025-11-01 06:10:00',
        NULL,
        '{"source":"Nespresso_KR"}',
        '2025-11-01 06:00:00'
    ),
    (
        6,
        'coffee_graph_process',
        'dag_coffee_etl',
        'task_neo4j_sync',
        'coffee',
        'GRAPH_PROCESS',
        '2025-11-01 07:00:00',
        'SUCCESS',
        60,
        1,
        0,
        '2025-11-01 07:00:00',
        '2025-11-01 07:08:00',
        NULL,
        '{"neo4j_version":"5.x"}',
        '2025-11-01 07:00:00'
    ),
    (
        7,
        'lighting_collect',
        'dag_lighting_etl',
        'task_hue_api_fetch',
        'lighting',
        'COLLECT',
        '2025-11-01 08:00:00',
        'SUCCESS',
        45,
        0,
        0,
        '2025-11-01 08:00:00',
        '2025-11-01 08:05:00',
        NULL,
        '{"source":"PhilipsHue_API"}',
        '2025-11-01 08:00:00'
    ),
    (
        8,
        'lighting_graph_process',
        'dag_lighting_etl',
        'task_neo4j_sync',
        'lighting',
        'GRAPH_PROCESS',
        '2025-11-01 09:00:00',
        'FAILED',
        30,
        15,
        0,
        '2025-11-01 09:00:00',
        '2025-11-01 09:12:00',
        'Neo4j connection refused: timeout after 30s',
        '{"neo4j_version":"5.x","retry":true}',
        '2025-11-01 09:00:00'
    ),
    (
        9,
        'movie_collect',
        'dag_movie_etl',
        'task_tmdb_fetch',
        'video',
        'COLLECT',
        '2025-11-08 02:00:00',
        'SUCCESS',
        25,
        0,
        1,
        '2025-11-08 02:00:00',
        '2025-11-08 02:08:00',
        NULL,
        '{"source":"TMDB","incremental":true}',
        '2025-11-08 02:00:00'
    ),
    (
        10,
        'music_collect',
        'dag_music_etl',
        'task_deezer_fetch',
        'music',
        'COLLECT',
        '2025-11-08 04:00:00',
        'SUCCESS',
        80,
        1,
        5,
        '2025-11-08 04:00:00',
        '2025-11-08 04:12:00',
        NULL,
        '{"source":"Deezer","batch_size":50}',
        '2025-11-08 04:00:00'
    ),
    (
        11,
        'lighting_collect',
        'dag_lighting_etl',
        'task_hue_api_fetch',
        'lighting',
        'COLLECT',
        '2025-11-08 08:00:00',
        'SUCCESS',
        10,
        0,
        0,
        '2025-11-08 08:00:00',
        '2025-11-08 08:03:00',
        NULL,
        '{"source":"PhilipsHue_API"}',
        '2025-11-08 08:00:00'
    ),
    (
        12,
        'lighting_graph_process',
        'dag_lighting_etl',
        'task_neo4j_sync',
        'lighting',
        'GRAPH_PROCESS',
        '2025-11-08 09:00:00',
        'SUCCESS',
        55,
        0,
        0,
        '2025-11-08 09:00:00',
        '2025-11-08 09:10:00',
        NULL,
        '{"neo4j_version":"5.x"}',
        '2025-11-08 09:00:00'
    ),
    (
        13,
        'coffee_collect',
        'dag_coffee_etl',
        'task_nespresso_scrape',
        'coffee',
        'COLLECT',
        '2025-11-15 06:00:00',
        'RUNNING',
        0,
        0,
        0,
        '2025-11-15 06:00:00',
        NULL,
        NULL,
        '{"source":"Nespresso_KR"}',
        '2025-11-15 06:00:00'
    ),
    (
        14,
        'movie_collect',
        'dag_movie_etl',
        'task_tmdb_fetch',
        'video',
        'COLLECT',
        '2025-11-15 02:00:00',
        'SUCCESS',
        18,
        0,
        0,
        '2025-11-15 02:00:00',
        '2025-11-15 02:06:00',
        NULL,
        '{"source":"TMDB","incremental":true}',
        '2025-11-15 02:00:00'
    ),
    (
        15,
        'music_graph_process',
        'dag_music_etl',
        'task_neo4j_sync',
        'music',
        'GRAPH_PROCESS',
        '2025-11-15 05:00:00',
        'SUCCESS',
        79,
        0,
        0,
        '2025-11-15 05:00:00',
        '2025-11-15 05:15:00',
        NULL,
        '{"neo4j_version":"5.x"}',
        '2025-11-15 05:00:00'
    ) ON CONFLICT (id) DO NOTHING;
-- [43/44] data_quality_checks (15건)
INSERT INTO data_quality_checks (
        check_id,
        etl_job_id,
        check_name,
        check_type,
        original_data,
        message,
        created_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        1,
        'null_check_title',
        'NULL_CHECK',
        '{"item_id":999,"title":null}',
        '영화 제목이 NULL입니다.',
        '2025-11-01 02:15:00'
    ),
    (
        2,
        1,
        'range_check_vote',
        'RANGE_CHECK',
        '{"item_id":998,"vote_average":11.5}',
        'vote_average 값이 0~10 범위를 초과합니다.',
        '2025-11-01 02:15:00'
    ),
    (
        3,
        2,
        'duplicate_check_node',
        'DUPLICATE_CHECK',
        '{"item_id":100,"neo4j_node":"n001"}',
        'Neo4j에 이미 동일 노드가 존재합니다.',
        '2025-11-01 03:15:00'
    ),
    (
        4,
        2,
        'relation_check_edge',
        'RELATION_CHECK',
        '{"from_id":100,"to_id":null}',
        '관계 대상 노드가 존재하지 않습니다.',
        '2025-11-01 03:20:00'
    ),
    (
        5,
        3,
        'null_check_artist',
        'NULL_CHECK',
        '{"item_id":997,"artists":null}',
        '아티스트 정보가 NULL입니다.',
        '2025-11-01 04:20:00'
    ),
    (
        6,
        3,
        'format_check_isrc',
        'FORMAT_CHECK',
        '{"item_id":996,"isrc":"INVALID"}',
        'ISRC 코드 형식이 올바르지 않습니다.',
        '2025-11-01 04:22:00'
    ),
    (
        7,
        3,
        'range_check_duration',
        'RANGE_CHECK',
        '{"item_id":995,"duration_ms":-1}',
        '트랙 재생 시간이 음수입니다.',
        '2025-11-01 04:23:00'
    ),
    (
        8,
        5,
        'null_check_capsule_name',
        'NULL_CHECK',
        '{"item_id":994,"capsule_name":null}',
        '캡슐 이름이 NULL입니다.',
        '2025-11-01 06:08:00'
    ),
    (
        9,
        5,
        'range_check_intensity',
        'RANGE_CHECK',
        '{"item_id":993,"intensity":15}',
        'intensity 값이 1~14 범위를 초과합니다.',
        '2025-11-01 06:09:00'
    ),
    (
        10,
        6,
        'relation_check_category',
        'RELATION_CHECK',
        '{"item_id":992,"category_id":999}',
        '존재하지 않는 카테고리 ID를 참조합니다.',
        '2025-11-01 07:05:00'
    ),
    (
        11,
        8,
        'connection_check_neo4j',
        'CONNECTION_CHECK',
        '{"host":"neo4j.local","port":7687}',
        'Neo4j 서버에 연결할 수 없습니다.',
        '2025-11-01 09:10:00'
    ),
    (
        12,
        8,
        'timeout_check_query',
        'TIMEOUT_CHECK',
        '{"query":"MATCH (n)-[r]->(m) RETURN n","timeout":30}',
        'Neo4j 쿼리 타임아웃 발생.',
        '2025-11-01 09:11:00'
    ),
    (
        13,
        10,
        'format_check_deezer_id',
        'FORMAT_CHECK',
        '{"item_id":991,"deezer_id":"abc"}',
        'Deezer ID는 정수여야 합니다.',
        '2025-11-08 04:10:00'
    ),
    (
        14,
        9,
        'duplicate_check_tmdb',
        'DUPLICATE_CHECK',
        '{"tmdb_id":496243,"existing_item_id":1}',
        'TMDB ID가 이미 등록된 아이템과 중복됩니다.',
        '2025-11-08 02:07:00'
    ),
    (
        15,
        14,
        'null_check_poster',
        'NULL_CHECK',
        '{"item_id":990,"poster_path":null}',
        '포스터 이미지 경로가 NULL입니다.',
        '2025-11-15 02:05:00'
    ) ON CONFLICT (check_id) DO NOTHING;
-- [44/44] lighting_products (15건)
INSERT INTO lighting_products (
        product_id,
        lighting_detail_id,
        product_name,
        brand,
        product_url,
        image_url,
        price,
        currency,
        color_temp_min,
        color_temp_max,
        has_dimming,
        has_rgb,
        source,
        source_product_id,
        is_available,
        created_at,
        updated_at
    ) OVERRIDING SYSTEM VALUE
VALUES (
        1,
        31,
        'Hue White Ambiance 펜던트',
        'Philips Hue',
        'https://www.philips-hue.com/ko-kr/p/pendant1',
        'https://cdn.vibelink.com/product/1.jpg',
        89000.00,
        'KRW',
        2200,
        6500,
        TRUE,
        FALSE,
        'hue',
        'HUE-PEND-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        2,
        32,
        'Hue Play 그래디언트 라이트바',
        'Philips Hue',
        'https://www.philips-hue.com/ko-kr/p/lightbar1',
        'https://cdn.vibelink.com/product/2.jpg',
        159000.00,
        'KRW',
        2000,
        6500,
        TRUE,
        TRUE,
        'hue',
        'HUE-PLAY-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        3,
        33,
        'IKEA STÖPEN LED 캔들',
        'IKEA',
        'https://www.ikea.com/kr/ko/p/stopen-led',
        'https://cdn.vibelink.com/product/3.jpg',
        12900.00,
        'KRW',
        1800,
        1800,
        FALSE,
        FALSE,
        'ikea',
        'IKEA-CANDLE-01',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        4,
        34,
        'Hue Lightstrip Plus V4',
        'Philips Hue',
        'https://www.philips-hue.com/ko-kr/p/strip1',
        'https://cdn.vibelink.com/product/4.jpg',
        109000.00,
        'KRW',
        2000,
        6500,
        TRUE,
        TRUE,
        'hue',
        'HUE-STRIP-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        5,
        35,
        'IKEA FLOALT LED 패널',
        'IKEA',
        'https://www.ikea.com/kr/ko/p/floalt-led',
        'https://cdn.vibelink.com/product/5.jpg',
        79900.00,
        'KRW',
        2700,
        5000,
        TRUE,
        FALSE,
        'ikea',
        'IKEA-PANEL-01',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        6,
        36,
        'IKEA TERTIAL 데스크 램프',
        'IKEA',
        'https://www.ikea.com/kr/ko/p/tertial-lamp',
        'https://cdn.vibelink.com/product/6.jpg',
        12900.00,
        'KRW',
        3000,
        4000,
        FALSE,
        FALSE,
        'ikea',
        'IKEA-DESK-01',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        7,
        37,
        'Hue LED 스트립 RGB',
        'Philips Hue',
        'https://www.philips-hue.com/ko-kr/p/rgb-strip',
        'https://cdn.vibelink.com/product/7.jpg',
        129000.00,
        'KRW',
        2000,
        6500,
        TRUE,
        TRUE,
        'hue',
        'HUE-RGB-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        8,
        38,
        'Hue Go 포터블 라이트',
        'Philips Hue',
        'https://www.philips-hue.com/ko-kr/p/go-light',
        'https://cdn.vibelink.com/product/8.jpg',
        99000.00,
        'KRW',
        2000,
        6500,
        TRUE,
        TRUE,
        'hue',
        'HUE-GO-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        9,
        39,
        '오하우스 카페 펜던트 조명',
        NULL,
        'https://ohou.se/productions/cafe-pendant',
        'https://cdn.vibelink.com/product/9.jpg',
        45000.00,
        'KRW',
        2700,
        2700,
        FALSE,
        FALSE,
        'ohouse',
        'OH-PEND-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        10,
        40,
        'IKEA SKURUP 천장 조명',
        'IKEA',
        'https://www.ikea.com/kr/ko/p/skurup-light',
        'https://cdn.vibelink.com/product/10.jpg',
        39900.00,
        'KRW',
        4000,
        5500,
        FALSE,
        FALSE,
        'ikea',
        'IKEA-CEIL-01',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        11,
        41,
        'Hue Bloom 테이블 램프',
        'Philips Hue',
        'https://www.philips-hue.com/ko-kr/p/bloom',
        'https://cdn.vibelink.com/product/11.jpg',
        89000.00,
        'KRW',
        2000,
        6500,
        TRUE,
        TRUE,
        'hue',
        'HUE-BLOOM-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        12,
        42,
        '오하우스 식물 LED 스트립',
        NULL,
        'https://ohou.se/productions/plant-led',
        'https://cdn.vibelink.com/product/12.jpg',
        29900.00,
        'KRW',
        3500,
        4500,
        TRUE,
        TRUE,
        'ohouse',
        'OH-LED-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        13,
        43,
        'Hue Infuse 천장 조명',
        'Philips Hue',
        'https://www.philips-hue.com/ko-kr/p/infuse',
        'https://cdn.vibelink.com/product/13.jpg',
        189000.00,
        'KRW',
        2000,
        6500,
        TRUE,
        TRUE,
        'hue',
        'HUE-INFUSE-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        14,
        44,
        'Hue Gradient Signe 플로어 램프',
        'Philips Hue',
        'https://www.philips-hue.com/ko-kr/p/signe',
        'https://cdn.vibelink.com/product/14.jpg',
        299000.00,
        'KRW',
        2000,
        6500,
        TRUE,
        TRUE,
        'hue',
        'HUE-SIGNE-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ),
    (
        15,
        45,
        '오하우스 벽난로 효과 LED 캔들',
        NULL,
        'https://ohou.se/productions/fireplace-led',
        'https://cdn.vibelink.com/product/15.jpg',
        19900.00,
        'KRW',
        1800,
        2500,
        TRUE,
        FALSE,
        'ohouse',
        'OH-CANDLE-001',
        TRUE,
        '2025-06-01 00:00:00',
        '2025-06-01 00:00:00'
    ) ON CONFLICT (product_id) DO NOTHING;
-- ============================================================
-- 시퀀스 리셋 (명시적 ID 삽입 후 auto-increment 정상화)
-- ============================================================
SELECT setval(
        'languages_language_id_seq',
        (
            SELECT MAX(language_id)
            FROM languages
        ),
        true
    );
SELECT setval(
        'mood_keywords_keyword_id_seq',
        (
            SELECT MAX(keyword_id)
            FROM mood_keywords
        ),
        true
    );
SELECT setval(
        'time_options_time_id_seq',
        (
            SELECT MAX(time_id)
            FROM time_options
        ),
        true
    );
SELECT setval(
        'weather_options_weather_id_seq',
        (
            SELECT MAX(weather_id)
            FROM weather_options
        ),
        true
    );
SELECT setval(
        'place_options_place_id_seq',
        (
            SELECT MAX(place_id)
            FROM place_options
        ),
        true
    );
SELECT setval(
        'companion_options_companion_id_seq',
        (
            SELECT MAX(companion_id)
            FROM companion_options
        ),
        true
    );
SELECT setval(
        'item_categories_category_id_seq',
        (
            SELECT MAX(category_id)
            FROM item_categories
        ),
        true
    );
SELECT setval(
        'users_user_id_seq',
        (
            SELECT MAX(user_id)
            FROM users
        ),
        true
    );
SELECT setval(
        'mood_keyword_translations_translation_id_seq',
        (
            SELECT MAX(translation_id)
            FROM mood_keyword_translations
        ),
        true
    );
SELECT setval(
        'weather_option_translations_translation_id_seq',
        (
            SELECT MAX(translation_id)
            FROM weather_option_translations
        ),
        true
    );
SELECT setval(
        'place_option_translations_translation_id_seq',
        (
            SELECT MAX(translation_id)
            FROM place_option_translations
        ),
        true
    );
SELECT setval(
        'companion_option_translations_translation_id_seq',
        (
            SELECT MAX(translation_id)
            FROM companion_option_translations
        ),
        true
    );
SELECT setval(
        'item_category_translations_translation_id_seq',
        (
            SELECT MAX(translation_id)
            FROM item_category_translations
        ),
        true
    );
SELECT setval(
        'items_item_id_seq',
        (
            SELECT MAX(item_id)
            FROM items
        ),
        true
    );
SELECT setval(
        'social_accounts_social_id_seq',
        (
            SELECT MAX(social_id)
            FROM social_accounts
        ),
        true
    );
SELECT setval(
        'user_settings_setting_id_seq',
        (
            SELECT MAX(setting_id)
            FROM user_settings
        ),
        true
    );
SELECT setval(
        'item_translations_translation_id_seq',
        (
            SELECT MAX(translation_id)
            FROM item_translations
        ),
        true
    );
SELECT setval(
        'neo4j_sync_status_sync_id_seq',
        (
            SELECT MAX(sync_id)
            FROM neo4j_sync_status
        ),
        true
    );
SELECT setval(
        'vibe_sessions_session_id_seq',
        (
            SELECT MAX(session_id)
            FROM vibe_sessions
        ),
        true
    );
SELECT setval(
        'archive_folders_folder_id_seq',
        (
            SELECT MAX(folder_id)
            FROM archive_folders
        ),
        true
    );
SELECT setval(
        'follows_follow_id_seq',
        (
            SELECT MAX(follow_id)
            FROM follows
        ),
        true
    );
SELECT setval(
        'notifications_notification_id_seq',
        (
            SELECT MAX(notification_id)
            FROM notifications
        ),
        true
    );
SELECT setval(
        'vibe_prompts_prompt_id_seq',
        (
            SELECT MAX(prompt_id)
            FROM vibe_prompts
        ),
        true
    );
SELECT setval(
        'archive_items_archive_item_id_seq',
        (
            SELECT MAX(archive_item_id)
            FROM archive_items
        ),
        true
    );
SELECT setval(
        'vibe_results_result_id_seq',
        (
            SELECT MAX(result_id)
            FROM vibe_results
        ),
        true
    );
SELECT setval(
        'vibe_items_vibe_item_id_seq',
        (
            SELECT MAX(vibe_item_id)
            FROM vibe_items
        ),
        true
    );
SELECT setval(
        'archive_vibes_archive_id_seq',
        (
            SELECT MAX(archive_id)
            FROM archive_vibes
        ),
        true
    );
SELECT setval(
        'feeds_feed_id_seq',
        (
            SELECT MAX(feed_id)
            FROM feeds
        ),
        true
    );
SELECT setval(
        'feed_reactions_reaction_id_seq',
        (
            SELECT MAX(reaction_id)
            FROM feed_reactions
        ),
        true
    );
SELECT setval(
        'feed_comments_comment_id_seq',
        (
            SELECT MAX(comment_id)
            FROM feed_comments
        ),
        true
    );
SELECT setval(
        'favorites_favorite_id_seq',
        (
            SELECT MAX(favorite_id)
            FROM favorites
        ),
        true
    );
SELECT setval(
        'comment_reactions_reaction_id_seq',
        (
            SELECT MAX(reaction_id)
            FROM comment_reactions
        ),
        true
    );
SELECT setval(
        'reports_report_id_seq',
        (
            SELECT MAX(report_id)
            FROM reports
        ),
        true
    );
SELECT setval(
        'external_connections_connection_id_seq',
        (
            SELECT MAX(connection_id)
            FROM external_connections
        ),
        true
    );
SELECT setval(
        'search_histories_history_id_seq',
        (
            SELECT MAX(history_id)
            FROM search_histories
        ),
        true
    );
SELECT setval(
        'trending_vibes_trend_id_seq',
        (
            SELECT MAX(trend_id)
            FROM trending_vibes
        ),
        true
    );
SELECT setval(
        'mood_trends_trend_id_seq',
        (
            SELECT MAX(trend_id)
            FROM mood_trends
        ),
        true
    );
SELECT setval(
        'etl_job_logs_id_seq',
        (
            SELECT MAX(id)
            FROM etl_job_logs
        ),
        true
    );
SELECT setval(
        'data_quality_checks_check_id_seq',
        (
            SELECT MAX(check_id)
            FROM data_quality_checks
        ),
        true
    );
SELECT setval(
        'lighting_products_product_id_seq',
        (
            SELECT MAX(product_id)
            FROM lighting_products
        ),
        true
    );