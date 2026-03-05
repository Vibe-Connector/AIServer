def build_context(categorized_items: dict[str, list[dict]]) -> str:
    """그래프 검색 결과를 LLM 컨텍스트 텍스트로 변환"""
    sections = []

    category_names = {
        "movie": "영화 (Movie)",
        "music": "음악 (Music)",
        "coffee": "커피 (Coffee)",
        "lighting": "조명 (Lighting)",
    }

    for category, items in categorized_items.items():
        if not items:
            continue

        cat_name = category_names.get(category, category)
        lines = [f"### {cat_name}"]

        for i, item in enumerate(items, 1):
            props = item.get("properties", {})
            score = item.get("score", 0)
            line = f"{i}. **{item['name']}** (item_id: {item['item_id']}, 그래프 점수: {score:.2f})"

            details = []
            if category == "movie":
                if props.get("genres"):
                    details.append(f"장르: {', '.join(props['genres'])}")
                if props.get("overview"):
                    details.append(f"개요: {props['overview'][:100]}")
                if props.get("vote_average"):
                    details.append(f"평점: {props['vote_average']}")
            elif category == "music":
                if props.get("artists"):
                    details.append(f"아티스트: {', '.join(props['artists'])}")
                if props.get("genres"):
                    details.append(f"장르: {', '.join(props['genres'])}")
                if props.get("album_name"):
                    details.append(f"앨범: {props['album_name']}")
            elif category == "coffee":
                if props.get("roast_level"):
                    details.append(f"로스팅: {props['roast_level']}")
                if props.get("intensity"):
                    details.append(f"강도: {props['intensity']}")
                if props.get("flavor_notes"):
                    details.append(f"풍미: {props['flavor_notes']}")
                if props.get("aroma_profile"):
                    details.append(f"아로마: {', '.join(props['aroma_profile'])}")
            elif category == "lighting":
                if props.get("color_temp_name"):
                    details.append(f"색온도: {props['color_temp_name']}")
                if props.get("color_temp_kelvin"):
                    details.append(f"{props['color_temp_kelvin']}K")
                if props.get("brightness_percent"):
                    details.append(f"밝기: {props['brightness_percent']}%")
                if props.get("lighting_type"):
                    details.append(f"타입: {props['lighting_type']}")

            if details:
                line += f"\n   - {' | '.join(details)}"
            lines.append(line)

        sections.append("\n".join(lines))

    if not sections:
        return "(지식 그래프에서 검색된 후보 아이템이 없습니다)"

    return "\n\n".join(sections)
