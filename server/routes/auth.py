from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter
from fastapi.param_functions import Depends
from sqlalchemy.orm.session import Session
from starlette.responses import JSONResponse, Response

import jwt
import bcrypt
from datetime import datetime, timedelta

from model import UserRegister, Token, UserOut
from database.conn import db
from database.schema import Users
from common.consts import JWT_SECRET, JWT_ALGORITHM
"""
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
405 Method not allowed
500 Internal Error
502 Bad Gateway 
504 Timeout
200 OK
201 Created
"""

router = APIRouter(prefix="/auth")


@router.post("/register", status_code=201)
async def register(reg_info: UserRegister,
                   session: Session = Depends(db.session)):
    """
    루트 사용자를 위한 회원가입 API\n
    """
    is_exist = await user_exist(reg_info.user_name)
    if not reg_info.user_name or not reg_info.password:
        #이름이나 비밀번호를 전송하지 않았을 경우
        return JSONResponse(
            status_code=400,
            content=dict(msg="user name and password must be provided"))
    if is_exist:
        #이미 아이디가 있으면 오류
        return JSONResponse(status_code=400, content=dict(msg="USER_EXISTS"))
    #비밀번호 해시화
    hash_pw = bcrypt.hashpw(reg_info.password.encode("utf-8"),
                            bcrypt.gensalt())
    #새로운 유저 생성
    new_user = Users.create(
        session,
        auto_commit=True,
        user_name=reg_info.user_name,
        password=hash_pw,
    )


@router.post("/login", status_code=200, response_model=Token)
async def login(user_info: UserRegister):
    """
    로그인 API
    """
    is_exist = await user_exist(user_name=user_info.user_name)
    #사용자 이름과 비밀번호가 제공 안되었을때
    if not user_info.user_name or not user_info.password:
        return JSONResponse(
            status_code=400,
            content=dict(msg="user_name or password must be provided"))
    #사용자 이름이 없는 경우
    if not is_exist:
        return JSONResponse(status_code=400, content=dict(msg="No Match User"))
    user = Users.get(user_name=user_info.user_name)
    is_verified = bcrypt.checkpw(user_info.password.encode("utf-8"),
                                 user.password.encode("utf-8"))
    #비밀번호 틀렸을 때
    if not is_verified:
        return JSONResponse(
            status_code=400,
            content=dict(msg="user_name or password must be provided"))
    token = dict(
        Authorization=
        f"Bearer {create_access_token(data=UserOut.from_orm(user).dict(),)}")
    return token


#계정이 있는지 확인
async def user_exist(user_name: str):
    userexist = Users.get(user_name=user_name)
    if userexist:
        return True
    return False


# 엑세스 토큰 만들기
def create_access_token(*, data: dict = None, expires_delta: int = None):
    to_encode = data.copy()
    if expires_delta:
        to_encode.update(
            {"exp": datetime.utcnow() + timedelta(hours=expires_delta)})
    encoded_jwt = jwt.encode(to_encode, JWT_SECRET, algorithm=JWT_ALGORITHM)
    return encoded_jwt