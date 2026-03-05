import structlog
from fastapi import Request
from fastapi.responses import JSONResponse

from app.core.exceptions import AIServerError

logger = structlog.get_logger()


async def aiserver_error_handler(request: Request, exc: AIServerError) -> JSONResponse:
    logger.error("aiserver_error", code=exc.code, message=exc.message, path=request.url.path)
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "success": False,
            "data": None,
            "code": exc.code,
            "message": exc.message,
        },
    )


async def unhandled_error_handler(request: Request, exc: Exception) -> JSONResponse:
    logger.exception("unhandled_error", path=request.url.path, error=str(exc))
    return JSONResponse(
        status_code=500,
        content={
            "success": False,
            "data": None,
            "code": "COM_001",
            "message": "서버 내부 오류가 발생했습니다",
        },
    )
