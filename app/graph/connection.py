from contextlib import asynccontextmanager
from typing import AsyncGenerator

import structlog
from neo4j import AsyncDriver, AsyncGraphDatabase

from app.config import settings

logger = structlog.get_logger()

_driver: AsyncDriver | None = None


async def init_driver() -> AsyncDriver:
    global _driver
    _driver = AsyncGraphDatabase.driver(
        settings.neo4j_uri,
        auth=(settings.neo4j_user, settings.neo4j_password),
    )
    await _driver.verify_connectivity()
    logger.info("neo4j_connected", uri=settings.neo4j_uri)
    return _driver


async def close_driver() -> None:
    global _driver
    if _driver:
        await _driver.close()
        _driver = None
        logger.info("neo4j_disconnected")


def get_driver() -> AsyncDriver:
    if _driver is None:
        raise RuntimeError("Neo4j driver not initialized")
    return _driver


@asynccontextmanager
async def get_session() -> AsyncGenerator:
    driver = get_driver()
    async with driver.session() as session:
        yield session
