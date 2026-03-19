#!/bin/bash
# ============================================================
# Neo4j Graph Data Export Script
# VibeConnector AIServer
# ============================================================
# APOC 플러그인을 사용하여 Neo4j 데이터를 Cypher + JSON 형태로 export합니다.
# export된 파일은 ./neo4j-import/ 디렉토리에 생성됩니다.
# ============================================================

set -euo pipefail

CONTAINER_NAME="vibeconnector-neo4j"
NEO4J_USER="neo4j"
NEO4J_PASS="vibeconnector2024"
EXPORT_DIR="./neo4j-import"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "=== VibeConnector Neo4j Data Export ==="
echo ""

# 1. 컨테이너 상태 확인
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "[ERROR] 컨테이너 '${CONTAINER_NAME}'이 실행 중이지 않습니다."
    echo "        docker compose up -d neo4j 로 먼저 시작해주세요."
    exit 1
fi

# 2. export 디렉토리 준비
mkdir -p "${EXPORT_DIR}"

# 3. APOC export 설정 확인
echo "[1/5] APOC 플러그인 확인 중..."
docker exec "${CONTAINER_NAME}" cypher-shell -u "${NEO4J_USER}" -p "${NEO4J_PASS}" \
    "RETURN apoc.version() AS version" 2>/dev/null || {
    echo "[ERROR] APOC 플러그인이 설치되어 있지 않습니다."
    echo "        docker-compose.yml에 NEO4J_PLUGINS=[\"apoc\"] 설정을 확인해주세요."
    exit 1
}
echo "  -> APOC 확인 완료"

# 4. 현재 그래프 통계 출력
echo ""
echo "[2/5] 현재 그래프 통계:"
docker exec "${CONTAINER_NAME}" cypher-shell -u "${NEO4J_USER}" -p "${NEO4J_PASS}" \
    "CALL apoc.meta.stats() YIELD nodeCount, relCount, labels, relTypes
     RETURN nodeCount, relCount, labels, relTypes"
echo ""

# 5. Cypher 형태로 export (가장 안정적인 import 포맷)
echo "[3/5] Cypher 형태로 export 중..."
docker exec "${CONTAINER_NAME}" cypher-shell -u "${NEO4J_USER}" -p "${NEO4J_PASS}" \
    "CALL apoc.export.cypher.all('export_all.cypher', {
        format: 'cypher-shell',
        useOptimizations: {type: 'UNWIND_BATCH', unwindBatchSize: 100}
    })
    YIELD file, nodes, relationships, properties, time
    RETURN file, nodes, relationships, properties, time"
echo "  -> Cypher export 완료: ${EXPORT_DIR}/export_all.cypher"

# 6. JSON 형태로도 export (백업용)
echo ""
echo "[4/5] JSON 형태로 export 중..."
docker exec "${CONTAINER_NAME}" cypher-shell -u "${NEO4J_USER}" -p "${NEO4J_PASS}" \
    "CALL apoc.export.json.all('export_all.json', {useTypes: true})
    YIELD file, nodes, relationships, properties, time
    RETURN file, nodes, relationships, properties, time"
echo "  -> JSON export 완료: ${EXPORT_DIR}/export_all.json"

# 7. 타임스탬프 복사본 생성
echo ""
echo "[5/5] 타임스탬프 아카이브 생성 중..."
if [ -f "${EXPORT_DIR}/export_all.cypher" ]; then
    cp "${EXPORT_DIR}/export_all.cypher" "${EXPORT_DIR}/export_${TIMESTAMP}.cypher"
    cp "${EXPORT_DIR}/export_all.json" "${EXPORT_DIR}/export_${TIMESTAMP}.json"
    echo "  -> ${EXPORT_DIR}/export_${TIMESTAMP}.cypher"
    echo "  -> ${EXPORT_DIR}/export_${TIMESTAMP}.json"
fi

# 8. 결과 요약
echo ""
echo "=== Export 완료 ==="
echo ""
echo "생성된 파일:"
ls -lh "${EXPORT_DIR}"/export_all.* 2>/dev/null || echo "  (파일 없음)"
echo ""
echo "동료에게 전달할 파일:"
echo "  1. ${EXPORT_DIR}/export_all.cypher  (Cypher import용)"
echo "  2. ${EXPORT_DIR}/export_all.json    (JSON import용, 백업)"
echo "  3. NEO4J_IMPORT_GUIDE.md            (import 가이드 문서)"
echo ""
echo "동료는 NEO4J_IMPORT_GUIDE.md를 따라 import하면 됩니다."
