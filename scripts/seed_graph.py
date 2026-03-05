"""
Neo4j 지식 그래프 초기 시드 스크립트.

사용법:
    cd AIServer
    python -m scripts.seed_graph

Backend에서 옵션/아이템 데이터를 가져와 그래프를 초기 구축합니다.
Backend가 실행 중이어야 합니다.
"""

import asyncio

from app.config import settings
from app.core.logging import setup_logging
from app.graph.connection import close_driver, init_driver
from app.graph.schema import apply_schema
from app.services.sync_service import full_sync


async def main() -> None:
    setup_logging(debug=True)
    print(f"=== VibeConnector GraphRAG Seed Script ===")
    print(f"Neo4j: {settings.neo4j_uri}")
    print(f"Backend: {settings.backend_url}")
    print()

    await init_driver()
    await apply_schema()

    print("전체 동기화 시작...")
    result = await full_sync()
    print(f"완료: {result.nodes_created}개 노드, {result.relationships_created}개 관계 ({result.duration_ms}ms)")

    await close_driver()


if __name__ == "__main__":
    asyncio.run(main())
