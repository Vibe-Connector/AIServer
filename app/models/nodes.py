from pydantic import BaseModel


class MoodNode(BaseModel):
    keyword_id: int
    keyword_value: str
    category: str = ""


class TimeNode(BaseModel):
    time_id: int
    time_key: str
    time_value: str = ""


class WeatherNode(BaseModel):
    weather_id: int
    weather_key: str


class PlaceNode(BaseModel):
    place_id: int
    place_key: str


class CompanionNode(BaseModel):
    companion_id: int
    companion_key: str


class CategoryNode(BaseModel):
    category_id: int
    category_key: str


class MovieNode(BaseModel):
    item_id: int
    item_key: str
    name: str
    tmdb_id: int | None = None
    genres: list[str] = []
    keywords: list[str] = []
    vote_average: float | None = None
    runtime: int | None = None
    overview: str = ""
    image_url: str = ""
    brand: str | None = None
    external_link: str | None = None
    external_service: str | None = None


class MusicNode(BaseModel):
    item_id: int
    item_key: str
    name: str
    artists: list[str] = []
    album_name: str = ""
    genres: list[str] = []
    spotify_uri: str = ""
    image_url: str = ""
    brand: str | None = None
    external_link: str | None = None
    external_service: str | None = None


class CoffeeNode(BaseModel):
    item_id: int
    item_key: str
    name: str
    capsule_name: str = ""
    intensity: int | None = None
    roast_level: str = ""
    flavor_notes: str = ""
    aroma_profile: list[str] = []
    body: int | None = None
    acidity: int | None = None
    image_url: str = ""
    brand: str | None = None
    external_link: str | None = None
    external_service: str | None = None


class LightingNode(BaseModel):
    item_id: int
    item_key: str
    name: str
    color_temp_kelvin: int | None = None
    color_temp_name: str = ""
    brightness_percent: int | None = None
    lighting_type: str = ""
    space_context: str = ""
    time_context: str = ""
    image_url: str = ""
    brand: str | None = None
    external_link: str | None = None
    external_service: str | None = None
