from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from fastapi.param_functions import Depends

from sqlalchemy.orm.session import Session

import bcrypt
from fastapi import APIRouter
from starlette.responses import JSONResponse

from model import UserRegister
from database.conn import db
from database.schema import Users

router = APIRouter(prefix="/auth")


@router.post("/register/")
async def register(reg_info: UserRegister,
                   session: Session = Depends(db.session)):
    """
    루트 사용자를 위한 회원가입 API\n
    """
    if not reg_info.user_name or not reg_info.pw:
        #이름이나 비밀번호를 전송하지 않았을 경우
        return JSONResponse(
            status_code=400,
            content=dict(msg="user name and pw must be provided"))
    #비밀번호 해시화
    hash_pw = bcrypt.hashpw(reg_info.pw.encode("utf-8"), bcrypt.gensalt())
    #새로운 유저 생성
    new_user = Users.create(session,
                            auto_commit=True,
                            pw=hash_pw,
                            user_name=reg_info.user_name)
