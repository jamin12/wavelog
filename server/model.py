from datetime import datetime
from enum import Enum

from pydantic import Field
from pydantic.main import BaseModel
from pydantic.networks import EmailStr, IPvAnyAddress
from sqlalchemy.sql.base import NO_ARG


#유저 인풋
class UserRegister(BaseModel):
    # pip install 'pydantic[email]'
    user_name: str = None
    password: str = None


#로그인 토큰
class Token(BaseModel):
    Authorization: str = None


#유저 아우풋
class UserOut(BaseModel):
    id: int = None
    user_name: str = None

    class Config:
        orm_mode = True


#유저 리스트 가져오기
class GetUserList(BaseModel):
    id: int = None
    user_name: str = None

    class Config:
        orm_mode = True


#카테고리 리스트 가져오기
class CatagoryList(BaseModel):
    catagory_name: str = None
    user_name: str = None

    class Config:
        orm_mode = True