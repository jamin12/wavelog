from datetime import datetime
from enum import Enum

from pydantic import Field
from pydantic.main import BaseModel
from pydantic.networks import EmailStr, IPvAnyAddress


class UserRegister(BaseModel):
    # pip install 'pydantic[email]'
    user_name: str = None
    password: str = None


class Token(BaseModel):
    Authorization: str = None


class UserOut(BaseModel):
    user_name: str = None

    class Config:
        orm_mode = True


class GetUserList(BaseModel):
    id: int = None
    user_name: str = None
    create_at: datetime = None
