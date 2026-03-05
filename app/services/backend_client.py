import httpx
import structlog

from app.config import settings
from app.core.exceptions import BackendClientError

logger = structlog.get_logger()


class BackendClient:
    def __init__(self) -> None:
        self._base_url = settings.backend_url
        self._client = httpx.AsyncClient(
            base_url=self._base_url,
            timeout=httpx.Timeout(connect=10.0, read=30.0, write=10.0, pool=10.0),
        )

    async def close(self) -> None:
        await self._client.aclose()

    async def _get(self, path: str, params: dict | None = None) -> dict:
        try:
            response = await self._client.get(path, params=params)
            response.raise_for_status()
            data = response.json()
            if isinstance(data, dict) and data.get("success") is False:
                raise BackendClientError(data.get("message", "Backend 요청 실패"))
            return data
        except httpx.HTTPError as e:
            logger.error("backend_request_error", path=path, error=str(e))
            raise BackendClientError(f"Backend 요청 실패: {e}") from e

    async def get_all_options(self, lang: str = "ko") -> dict:
        return await self._get("/options", params={"lang": lang})

    async def get_movie_detail(self, item_id: int) -> dict:
        return await self._get(f"/items/{item_id}/movie")

    async def get_music_detail(self, item_id: int) -> dict:
        return await self._get(f"/items/{item_id}/music")

    async def get_coffee_detail(self, item_id: int) -> dict:
        return await self._get(f"/items/{item_id}/coffee")

    async def get_lighting_detail(self, item_id: int) -> dict:
        return await self._get(f"/items/{item_id}/lighting")


backend_client = BackendClient()
