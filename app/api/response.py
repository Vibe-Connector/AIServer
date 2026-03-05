from typing import Any, Generic, Optional, TypeVar

from pydantic import BaseModel

T = TypeVar("T")


class ApiResponse(BaseModel, Generic[T]):
    success: bool
    data: Optional[T] = None
    code: Optional[str] = None
    message: Optional[str] = None

    @classmethod
    def ok(cls, data: Any = None) -> "ApiResponse":
        return cls(success=True, data=data)

    @classmethod
    def error(cls, code: str, message: str) -> "ApiResponse":
        return cls(success=False, code=code, message=message)
