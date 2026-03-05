class AIServerError(Exception):
    def __init__(self, code: str, message: str, status_code: int = 500):
        self.code = code
        self.message = message
        self.status_code = status_code
        super().__init__(message)


class GraphConnectionError(AIServerError):
    def __init__(self, message: str = "Neo4j 연결에 실패했습니다"):
        super().__init__(code="GRAPH_001", message=message, status_code=503)


class GraphQueryError(AIServerError):
    def __init__(self, message: str = "그래프 쿼리 실행에 실패했습니다"):
        super().__init__(code="GRAPH_002", message=message, status_code=500)


class GraphNotFoundError(AIServerError):
    def __init__(self, message: str = "요청한 노드를 찾을 수 없습니다"):
        super().__init__(code="GRAPH_003", message=message, status_code=404)


class LLMError(AIServerError):
    def __init__(self, message: str = "LLM 호출에 실패했습니다"):
        super().__init__(code="LLM_001", message=message, status_code=502)


class SyncError(AIServerError):
    def __init__(self, message: str = "데이터 동기화에 실패했습니다"):
        super().__init__(code="SYNC_001", message=message, status_code=500)


class BackendClientError(AIServerError):
    def __init__(self, message: str = "Backend 서버 통신에 실패했습니다"):
        super().__init__(code="BACKEND_001", message=message, status_code=502)


class IngestError(AIServerError):
    def __init__(self, message: str = "데이터 수집에 실패했습니다"):
        super().__init__(code="INGEST_001", message=message, status_code=400)
