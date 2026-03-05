from typing import Any

import structlog
from neo4j import AsyncManagedTransaction, Record

from app.core.exceptions import GraphQueryError
from app.graph.connection import get_session

logger = structlog.get_logger()


async def execute_read(query: str, parameters: dict[str, Any] | None = None) -> list[Record]:
    try:
        async with get_session() as session:

            async def _read(tx: AsyncManagedTransaction) -> list[Record]:
                result = await tx.run(query, parameters or {})
                return [record async for record in result]

            return await session.execute_read(_read)
    except Exception as e:
        logger.error("graph_read_error", query=query[:100], error=str(e))
        raise GraphQueryError(f"그래프 읽기 실패: {e}") from e


async def execute_write(query: str, parameters: dict[str, Any] | None = None) -> list[Record]:
    try:
        async with get_session() as session:

            async def _write(tx: AsyncManagedTransaction) -> list[Record]:
                result = await tx.run(query, parameters or {})
                return [record async for record in result]

            return await session.execute_write(_write)
    except Exception as e:
        logger.error("graph_write_error", query=query[:100], error=str(e))
        raise GraphQueryError(f"그래프 쓰기 실패: {e}") from e


async def execute_write_batch(
    queries: list[tuple[str, dict[str, Any] | None]],
) -> None:
    try:
        async with get_session() as session:

            async def _batch(tx: AsyncManagedTransaction) -> None:
                for query, params in queries:
                    await tx.run(query, params or {})

            await session.execute_write(_batch)
    except Exception as e:
        logger.error("graph_batch_error", count=len(queries), error=str(e))
        raise GraphQueryError(f"그래프 배치 쓰기 실패: {e}") from e
