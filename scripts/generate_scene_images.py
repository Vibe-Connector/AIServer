"""
Vibe Scene Image Generator
Generates 225 images (15 places × 15 companions) using DALL-E 3
and uploads them to S3.

Usage:
    cd AIServer
    source .venv/bin/activate
    python scripts/generate_scene_images.py
"""

import json
import os
import sys
import time
from pathlib import Path

import boto3
import httpx
from openai import OpenAI

# ── Configuration ────────────────────────────────────────────────────────────
OPENAI_API_KEY = os.getenv(
    "OPENAI_API_KEY",
    "",
)
AWS_ACCESS_KEY = os.getenv("AWS_ACCESS_KEY", "")
AWS_SECRET_KEY = os.getenv("AWS_SECRET_KEY", "")
AWS_S3_BUCKET = os.getenv("AWS_S3_BUCKET", "")
AWS_REGION = os.getenv("AWS_REGION", "")

S3_PREFIX = "vibe-scenes"
IMAGE_SIZE = "1024x1792"
IMAGE_QUALITY = "standard"
DALLE_MODEL = "dall-e-3"

# Progress file for resume capability
PROGRESS_FILE = Path(__file__).parent / "scene_gen_progress.json"

# ── Place & Companion Definitions ────────────────────────────────────────────
PLACES = {
    "home": "a cozy home living room with warm lighting and comfortable furniture",
    "cafe": "a warm, inviting café interior with wooden tables and coffee aroma atmosphere",
    "office": "a modern office workspace with desks and natural light",
    "park": "a green park with trees, walking paths, and open grass areas",
    "beach": "a sandy beach with gentle ocean waves and clear sky",
    "mountain": "a mountain trail surrounded by nature with scenic panoramic views",
    "library": "a quiet library interior with tall bookshelves and reading areas",
    "restaurant": "an elegant restaurant dining area with table settings",
    "bar": "a moody bar interior with ambient dim lighting and a counter",
    "studio": "a creative art studio workspace with canvases and art supplies",
    "bedroom": "a comfortable bedroom with a bed, soft pillows, and warm lighting",
    "rooftop": "a rooftop terrace with a city skyline view at golden hour",
    "car": "the interior of a car, looking out through the windshield at scenery",
    "train": "inside a train compartment, looking out the window at passing landscape",
    "bookstore": "a charming indie bookstore with wooden shelves full of books",
}

COMPANIONS = {
    "alone": "a single person enjoying peaceful solitude",
    "partner": "a romantic couple together, sharing an intimate moment",
    "friends": "a small group of friends laughing and hanging out together",
    "family": "a family with parents and children spending quality time together",
    "pet": "a person with their beloved pet (a dog or cat) beside them",
    "colleagues": "coworkers in a casual, friendly professional setting",
    "child": "an adult gently caring for a young child",
    "parents": "a person spending time with their elderly parents",
    "sibling": "siblings together, sharing a comfortable moment",
    "best_friend": "two close best friends side by side, relaxed and happy",
    "stranger": "a person among strangers in a public setting, observing the scene",
    "mentor": "a mentor and mentee engaged in thoughtful conversation",
    "group": "a lively large group of people gathered together",
    "date": "two people on a romantic date, with subtle chemistry",
    "classmates": "classmates together in a youthful, academic atmosphere",
}


def build_prompt(place_key: str, companion_key: str) -> str:
    place_desc = PLACES[place_key]
    companion_desc = COMPANIONS[companion_key]
    return (
        f"A photorealistic, high-quality illustration of a scene: {place_desc}. "
        f"In this setting, {companion_desc}. "
        f"The image should clearly depict the location and the people present. "
        f"Warm, natural color palette. No text or watermarks. "
        f"Vertical composition (portrait orientation). "
        f"Soft, cinematic lighting. Lifestyle photography style."
    )


def load_progress() -> set:
    """Load completed image keys from progress file."""
    if PROGRESS_FILE.exists():
        data = json.loads(PROGRESS_FILE.read_text())
        return set(data.get("completed", []))
    return set()


def save_progress(completed: set):
    """Save completed image keys to progress file."""
    PROGRESS_FILE.write_text(json.dumps({"completed": sorted(completed)}))


def main():
    client = OpenAI(api_key=OPENAI_API_KEY)

    s3 = boto3.client(
        "s3",
        aws_access_key_id=AWS_ACCESS_KEY,
        aws_secret_access_key=AWS_SECRET_KEY,
        region_name=AWS_REGION,
    )

    http = httpx.Client(timeout=60)

    place_keys = list(PLACES.keys())
    companion_keys = list(COMPANIONS.keys())
    total = len(place_keys) * len(companion_keys)

    completed = load_progress()
    print(f"총 {total}개 이미지 생성 예정, 이미 완료: {len(completed)}개")
    print(f"남은 작업: {total - len(completed)}개\n")

    count = len(completed)

    for place in place_keys:
        for companion in companion_keys:
            key = f"{place}_{companion}"
            s3_key = f"{S3_PREFIX}/{key}.png"

            if key in completed:
                continue

            prompt = build_prompt(place, companion)
            print(f"[{count + 1}/{total}] 생성 중: {key}")
            print(f"  프롬프트: {prompt[:80]}...")

            try:
                # Generate image with DALL-E 3
                response = client.images.generate(
                    model=DALLE_MODEL,
                    prompt=prompt,
                    size=IMAGE_SIZE,
                    quality=IMAGE_QUALITY,
                    n=1,
                )

                image_url = response.data[0].url

                # Download image
                img_response = http.get(image_url)
                img_response.raise_for_status()
                img_bytes = img_response.content

                # Upload to S3
                s3.put_object(
                    Bucket=AWS_S3_BUCKET,
                    Key=s3_key,
                    Body=img_bytes,
                    ContentType="image/png",
                )

                count += 1
                completed.add(key)
                save_progress(completed)

                s3_url = f"https://{AWS_S3_BUCKET}.s3.{AWS_REGION}.amazonaws.com/{s3_key}"
                print(f"  ✓ 완료! ({count}/{total}) → {s3_url}\n")

                # Rate limit: DALL-E 3 ~5 req/min → 13초 간격
                if count < total:
                    time.sleep(13)

            except Exception as e:
                print(f"  ✗ 실패: {e}")
                print(f"  → 15초 후 재시도...\n")
                time.sleep(15)
                try:
                    response = client.images.generate(
                        model=DALLE_MODEL,
                        prompt=prompt,
                        size=IMAGE_SIZE,
                        quality=IMAGE_QUALITY,
                        n=1,
                    )
                    image_url = response.data[0].url
                    img_response = http.get(image_url)
                    img_response.raise_for_status()
                    img_bytes = img_response.content

                    s3.put_object(
                        Bucket=AWS_S3_BUCKET,
                        Key=s3_key,
                        Body=img_bytes,
                        ContentType="image/png",
                    )

                    count += 1
                    completed.add(key)
                    save_progress(completed)
                    print(f"  ✓ 재시도 성공! ({count}/{total})\n")
                    time.sleep(13)
                except Exception as e2:
                    print(f"  ✗ 재시도도 실패: {e2}")
                    print(f"  → 건너뛰고 계속 진행...\n")
                    time.sleep(13)

    print(f"\n{'='*60}")
    print(f"완료! 총 {count}/{total}개 이미지 생성됨")
    if count < total:
        missed = total - count
        print(f"미완료 {missed}개는 스크립트를 다시 실행하면 이어서 생성됩니다.")
    print(f"S3 경로: s3://{AWS_S3_BUCKET}/{S3_PREFIX}/")
    print(f"{'='*60}")


if __name__ == "__main__":
    main()
