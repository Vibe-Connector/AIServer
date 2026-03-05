from contextlib import asynccontextmanager

import structlog
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.v1.router import v1_router
from app.config import settings
from app.core.error_handlers import aiserver_error_handler, unhandled_error_handler
from app.core.exceptions import AIServerError
from app.core.logging import setup_logging
from app.graph.connection import close_driver, init_driver
from app.graph.schema import apply_schema

logger = structlog.get_logger()


@asynccontextmanager
async def lifespan(app: FastAPI):
    setup_logging(debug=settings.app_debug)
    logger.info("aiserver_starting", name=settings.app_name)

    await init_driver()
    await apply_schema()

    logger.info("aiserver_ready", port=settings.app_port)
    yield

    await close_driver()
    logger.info("aiserver_stopped")


app = FastAPI(
    title=settings.app_name,
    version="0.1.0",
    lifespan=lifespan,
    docs_url="/docs",
    redoc_url="/redoc",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:3000",
        "http://localhost:5173",
        "http://localhost:8080",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.add_exception_handler(AIServerError, aiserver_error_handler)
app.add_exception_handler(Exception, unhandled_error_handler)

app.include_router(v1_router)
