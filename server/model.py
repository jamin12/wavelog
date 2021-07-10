from pydantic import Field
from pydantic.main import BaseModel
from pydantic.networks import EmailStr
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
    id: int = None
    user_name: str = None
    email: EmailStr = None
    phone_num: str = None
    residence: str = None

    class Config:
        orm_mode = True


#유저 리스트 가져오기
class GetUserList(BaseModel):
    id: int = None
    user_name: str = None
    email: EmailStr = None
    phone_num: str = None
    residence: str = None

    class Config:
        orm_mode = True


#카테고리 레지스터
class CatagoryRegister(BaseModel):
    catagory_name: str = None
    catagory_color: str = None


#카테고리 리스트
class CatagoryList(BaseModel):
    id: int = None
    catagory_name: str = None
    catagory_color: str = None
    user_id: int = None

    class Config:
        orm_mode = True


#카테고리 삭제
class CatagoryDelete(BaseModel):
    catagory_name: str = None


#게시물 레지스터
class PostRegister(BaseModel):
    post_title: str = None
    post_body: str = None
    catagory_id: int = None


class GetPostList(BaseModel):
    post_title: str = None
    catagory_id: int = None
    user_id: int = None

    class Config:
        orm_mode = True


class UpdatePost(BaseModel):
    post_id: int = None
    post_title: str = None
    post_body: str = None
    catagory_id: int = None


class noticeboard(BaseModel):
    catagory_name: str = None
    catagory_color: str = None


#메시지 OK
class MessageOk(BaseModel):
    message: str = Field(default="OK")
