import json

import structlog
from langchain_core.messages import HumanMessage, SystemMessage
from langchain_openai import ChatOpenAI

from app.config import settings
from app.core.exceptions import LLMError
from app.rag.prompt_templates import RECOMMEND_SYSTEM_PROMPT, build_recommend_user_prompt

logger = structlog.get_logger()

_llm: ChatOpenAI | None = None


def get_llm() -> ChatOpenAI:
    global _llm
    if _llm is None:
        _llm = ChatOpenAI(
            api_key=settings.openai_api_key,
            model=settings.openai_model,
            max_tokens=settings.openai_max_tokens,
            temperature=settings.openai_temperature,
        )
    return _llm


async def generate_recommendation(
    graph_context: str,
    mood_keywords: list[str],
    time_key: str,
    weather_key: str,
    place_key: str,
    companion_key: str,
) -> dict:
    llm = get_llm()

    user_prompt = build_recommend_user_prompt(
        graph_context=graph_context,
        mood_keywords=mood_keywords,
        time_key=time_key,
        weather_key=weather_key,
        place_key=place_key,
        companion_key=companion_key,
    )

    try:
        response = await llm.ainvoke([
            SystemMessage(content=RECOMMEND_SYSTEM_PROMPT),
            HumanMessage(content=user_prompt),
        ])

        content = response.content.strip()
        # JSON 블록 추출
        if "```json" in content:
            content = content.split("```json")[1].split("```")[0].strip()
        elif "```" in content:
            content = content.split("```")[1].split("```")[0].strip()

        return json.loads(content)

    except json.JSONDecodeError as e:
        logger.error("llm_json_parse_error", error=str(e), raw=content[:200])
        raise LLMError(f"LLM 응답 파싱 실패: {e}") from e
    except Exception as e:
        logger.error("llm_call_error", error=str(e))
        raise LLMError(f"LLM 호출 실패: {e}") from e


async def evaluate_item_fitness(
    item_description: str,
    moods: list[dict],
    times: list[dict],
    weathers: list[dict],
    places: list[dict],
    companions: list[dict],
) -> dict:
    """LLM을 사용하여 아이템이 어떤 컨텍스트에 적합한지 평가"""
    llm = get_llm()

    system = (
        "당신은 아이템과 분위기의 적합도를 평가하는 전문가입니다.\n"
        "주어진 아이템 설명을 보고, 각 분위기/시간/날씨/장소/동반자 옵션과의 적합도를 "
        "0.0~1.0 사이 점수로 평가하세요.\n"
        "0.3 미만은 '적합하지 않음', 0.3~0.6은 '보통', 0.6 이상은 '적합'을 의미합니다.\n"
        "JSON 형식으로 응답하세요."
    )

    user = (
        f"아이템: {item_description}\n\n"
        f"Moods: {json.dumps(moods, ensure_ascii=False)}\n"
        f"Times: {json.dumps(times, ensure_ascii=False)}\n"
        f"Weathers: {json.dumps(weathers, ensure_ascii=False)}\n"
        f"Places: {json.dumps(places, ensure_ascii=False)}\n"
        f"Companions: {json.dumps(companions, ensure_ascii=False)}\n\n"
        "각 옵션에 대해 적합도 점수를 매겨주세요. 형식:\n"
        '{"moods": {"keyword_id": score, ...}, "times": {"time_id": score, ...}, '
        '"weathers": {"weather_id": score, ...}, "places": {"place_id": score, ...}, '
        '"companions": {"companion_id": score, ...}}'
    )

    try:
        response = await llm.ainvoke([
            SystemMessage(content=system),
            HumanMessage(content=user),
        ])
        content = response.content.strip()
        if "```json" in content:
            content = content.split("```json")[1].split("```")[0].strip()
        elif "```" in content:
            content = content.split("```")[1].split("```")[0].strip()
        return json.loads(content)
    except Exception as e:
        logger.error("fitness_eval_error", error=str(e))
        raise LLMError(f"아이템 적합도 평가 실패: {e}") from e
