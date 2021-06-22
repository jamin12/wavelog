from pydantic import Field
from pydantic.main import BaseModel


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


#유저 토큰
class UserToken(BaseModel):
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


#카테고리 리스트
class CatagoryList(BaseModel):
    catagory_name: str = None
    catagory_color: str = None


#카테고리 레지스터
class CatagoryRegister(BaseModel):
    catagory_name: str = None
    catagory_color: str = None


#카테고리 삭제
class CatagoryDelete(BaseModel):
    catagory_name: str = None


#메인 페이지 뷰
class Mainpage(BaseModel):
    user_name: str = None
    catagory_name: str = None
    catagory_color: str = None


#메시지 OK
class MessageOk(BaseModel):
    message: str = Field(default="OK")
