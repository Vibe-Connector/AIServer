from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    # Server
    app_name: str = "VibeConnector AIServer"
    app_debug: bool = False
    app_host: str = "0.0.0.0"
    app_port: int = 8000

    # Neo4j
    neo4j_uri: str = "bolt://localhost:7687"
    neo4j_user: str = "neo4j"
    neo4j_password: str = "vibeconnector2024"

    # OpenAI
    openai_api_key: str = ""
    openai_model: str = "gpt-4o-mini"
    openai_max_tokens: int = 1000
    openai_temperature: float = 0.8

    # Backend
    backend_base_url: str = "http://localhost:8080"
    backend_api_prefix: str = "/api/v1"

    # RAG
    max_graph_traversal_depth: int = 3
    max_items_per_category: int = 3
    relationship_weight_threshold: float = 0.3

    @property
    def backend_url(self) -> str:
        return f"{self.backend_base_url}{self.backend_api_prefix}"


settings = Settings()
