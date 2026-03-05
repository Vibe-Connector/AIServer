from pydantic import BaseModel


class WeatherIntensity(BaseModel):
    weather_option_id: int
    intensity: float = 1.0


class VibeRecommendRequest(BaseModel):
    mood_keyword_ids: list[int]
    mood_keywords: list[str] = []
    time_id: int
    time_key: str = ""
    weather_id: int
    weather_key: str = ""
    place_id: int
    place_key: str = ""
    companion_id: int
    companion_key: str = ""
    hour: int | None = None
    minute: int | None = None
    weather_intensities: list[WeatherIntensity] = []
    lang: str = "ko"
    max_items_per_category: int = 3


class RecommendedItem(BaseModel):
    item_id: int
    item_key: str
    name: str
    category: str
    relevance_score: float
    reason: str = ""
    image_url: str = ""
    brand: str | None = None
    external_link: str | None = None
    external_service: str | None = None


class CategoryRecommendation(BaseModel):
    category_key: str
    items: list[RecommendedItem]


class VibeRecommendResponse(BaseModel):
    phrase: str
    analysis: str
    recommendations: list[CategoryRecommendation] = []
    processing_time_ms: int = 0
    graph_context: dict = {}
