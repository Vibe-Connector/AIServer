from neo4j import AsyncDriver

from app.graph.connection import get_driver


async def get_neo4j() -> AsyncDriver:
    return get_driver()
