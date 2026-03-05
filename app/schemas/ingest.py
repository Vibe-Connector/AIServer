from pydantic import BaseModel


class MoodOptionData(BaseModel):
    keyword_id: int
    keyword_value: str
    category: str = ""


class TimeOptionData(BaseModel):
    time_id: int
    time_key: str
    time_value: str = ""


class WeatherOptionData(BaseModel):
    weather_id: int
    weather_key: str


class PlaceOptionData(BaseModel):
    place_id: int
    place_key: str


class CompanionOptionData(BaseModel):
    companion_id: int
    companion_key: str


class IngestOptionsRequest(BaseModel):
    moods: list[MoodOptionData] = []
    times: list[TimeOptionData] = []
    weathers: list[WeatherOptionData] = []
    places: list[PlaceOptionData] = []
    companions: list[CompanionOptionData] = []


class ItemData(BaseModel):
    item_id: int
    item_key: str
    category_key: str
    name: str
    image_url: str = ""
    details: dict = {}


class IngestItemsRequest(BaseModel):
    items: list[ItemData]


class IngestVibeSessionRequest(BaseModel):
    session_id: int
    user_id: int
    mood_keywords: list[str]
    mood_keyword_ids: list[int] = []
    time_key: str
    time_id: int | None = None
    weather_key: str
    weather_id: int | None = None
    place_key: str
    place_id: int | None = None
    companion_key: str
    companion_id: int | None = None
    phrase: str = ""
    analysis: str = ""
    recommended_item_ids: list[int] = []


class IngestResult(BaseModel):
    nodes_created: int = 0
    relationships_created: int = 0
    message: str = ""
