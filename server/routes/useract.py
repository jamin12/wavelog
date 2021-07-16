from os import path as op
import re
from sys import path as sp
from sqlalchemy.sql.expression import update

from starlette.responses import JSONResponse

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter
from starlette.requests import Request
from inspect import currentframe as frame
from fastapi.param_functions import Depends

from database.schema import *
import model as m

router = APIRouter(prefix="/useract")


#내 정보
@router.get("/me", response_model=m.UserToken)
async def get_me(request: Request):
    user = request.state.user
    user_info = Users.get(id=user.id)

    return user_info


#아이디 수정
@router.put("/me/{myname}")
async def put_me(request: Request, my_name: str):
    user = request.state.user
    me = Users.filter(id=user.id)
    if me:
        me.update(auto_commit=True, user_name=my_name)

    return m.MessageOk()


#아이디 삭제
@router.delete("/me")
async def delete_me(request: Request):
    user = request.state.user
    Users.filter(id=user.id).delete(auto_commit=True)

    return m.MessageOk()


#카테고리 생성
@router.post("/category", status_code=201)
async def create_category(request: Request,
                          reg_info: m.CategoryRegister,
                          session: Session = Depends(db.session)):
    try:
        user = request.state.user
        Categories.create(
            session=session,
            auto_commit=True,
            user_id=user.id,
            **reg_info.dict(),
        )
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.put("/category")
async def update_category(request: Request):
    try:
        user = request.state.user
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.post("/post", status_code=201)
async def create_post(request: Request,
                      reg_info: m.PostRegister,
                      session: Session = Depends(db.session)):
    try:
        user = request.state.user
        user_category_list = []
        usercategorys = Categories.filter(user_id=user.id).all()
        for usercategory in usercategorys:
            user_category_list.append(usercategory.id)
        if reg_info.category_id not in user_category_list:
            return JSONResponse(status_code=400,
                                content={"msg": "비정상적인 접근입니다."})
        Posts.create(
            session=session,
            auto_commit=True,
            **reg_info.dict(exclude={"post_body"}),
            user_id=user.id,
        )
        PostBody.create(session=session,
                        auto_commit=True,
                        post_body=reg_info.post_body,
                        post_id=Posts.filter().order_by("-id").first().id)

    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


"""
Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidXNlcl9uYW1lIjoidGVzdDEiLCJlbWFpbCI6InRlc3QxQGV4YW1wbGUuY29tIiwicGhvbmVfbnVtIjoiMDEwLTEyMzQtNTY3OCIsInJlc2lkZW5jZSI6InRlc3QxIn0.gFvOGD7fW3HRcqYV2026VL1ZuWiskQAVtuJW3gjYciM
Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MiwidXNlcl9uYW1lIjoidGVzdDIiLCJlbWFpbCI6InRlc3QyQGV4YW1wbGUuY29tIiwicGhvbmVfbnVtIjoiMDEwLTEyMzQtNTY3OCIsInJlc2lkZW5jZSI6InRlc3QyIn0.J0SUmtYYx57ZGongUL1DIhDmvqiKEDTFjutKgwnD9U8
"""
"""
{
  "user_name": "test1",
  "password": "qwer1234",
  "email": "test1@example.com",
  "phone_num": "010-1234-5678",
  "residence": "test1"
}
{
  "user_name": "test2",
  "password": "qwer1234",
  "email": "test2@example.com",
  "phone_num": "010-1234-5678",
  "residence": "test2"
}
"""