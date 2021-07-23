from pydantic import Field
from pydantic.main import BaseModel
from pydantic.networks import EmailStr
from typing import Dict, List, Optional
"""
TODO 
orm_mode 이놈 뭐하는 친구인지 이해하기..... 
저번에는 이해한거 같았는데 아닌갑네 또 모르겠어
TODO
erd 모델 바뀐후 model 변경 안함.......하.....
열심히 바꿔야지
"""


#유저 생성
class UserRegister(BaseModel):
    # pip install 'pydantic[email]'
    user_name: str = None
    password: str = None
    email: EmailStr = None
    phone_num: str = None
    residence: str = None


#유저 로그인
class UserLogin(BaseModel):
    user_name: str = None
    password: str = None


#로그인 토큰
class Token(BaseModel):
    Authorization: str = None


#유저 아우풋
class UserToken(BaseModel):
    user_id: int = None
    user_name: str = None
    email: EmailStr = None
    phone_num: str = None
    residence: str = None

    class Config:
        orm_mode = True


#카테고리 레지스터
class CategoryRegister(BaseModel):
    category_name: str = None
    category_color: str = None


#게시물 레지스터
class PostRegister(BaseModel):
    post_title: str = None
    post_body: str = None
    category_id: int = None


#게시물 수정
class PostUpdate(BaseModel):
    post_id: int = None
    post_title: str = None
    post_body: str = None
    category_id: int = None


#컨텐츠 페이지
class contents(BaseModel):
    post_id: int = None
    category_id: int = None
    category_name: str = None
    category_color: str = None
    post_title: str = None

    class Config:
        orm_mode = True


#게시물 페이지
class GetPost(BaseModel):
    post_title: str = None
    post_body: str = None
    comment: List[str] = None

    class Config:
        orm_mode = True


#댓글
class CommentRegister(BaseModel):
    post_id: int = None
    nick_name: str = None
    password: str = None
    comment_body: str = None


#메시지 OK
class MessageOk(BaseModel):
    message: str = Field(default="OK")
