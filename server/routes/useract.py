from enum import auto
from os import path as op
import re
from sys import path as sp
from sqlalchemy.sql.expression import null, update
from sqlalchemy.sql.operators import exists

from starlette.responses import JSONResponse

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter
from starlette.requests import Request
from inspect import currentframe as frame
from fastapi.param_functions import Depends

from database.schema import *
import model as m

router = APIRouter(prefix="/useract")

# #내 정보
# @router.get("/me", response_model=m.UserToken)
# async def get_me(request: Request):
#     user = request.state.user
#     user_info = Users.get(user_id=user.user_id)

#     return user_info

# #아이디 수정
# @router.put("/me/{myname}")
# async def put_me(request: Request, my_name: str):
#     user = request.state.user
#     me = Users.filter(user_id=user.user_id)
#     if me:
#         me.update(auto_commit=True, user_name=my_name)

#     return m.MessageOk()

# #아이디 삭제
# @router.delete("/me")
# async def delete_me(request: Request):
#     user = request.state.user
#     Users.filter(user_id=user.user_id).delete(auto_commit=True)

#     return m.MessageOk()


@router.post("/category", status_code=201)
async def create_category(request: Request,
                          reg_info: m.CategoryRegister,
                          session: Session = Depends(db.session)):
    """
    카테고리 생성
    """
    try:
        user = request.state.user
        Categories.create(
            session=session,
            auto_commit=True,
            user_id=user.user_id,
            **reg_info.dict(),
        )
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.put("/category/{category_id}/{category_rename}")
async def update_category(request: Request, category_id: int,
                          category_rename: str):
    """
    카테고리 수정
    """
    try:
        Categories.filter(category_id=category_id).update(
            auto_commit=True, category_name=category_rename)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.delete("/category/{category_id}")
async def delete_category(request: Request, category_id: int):
    """
    카테고리 삭제
    """
    try:
        Categories.filter(category_id=category_id).delete(auto_commit=True)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.post("/post", status_code=201)
async def create_post(request: Request,
                      reg_info: m.PostRegister,
                      session: Session = Depends(db.session)):
    """
    게시물 생성
    """
    try:
        user = request.state.user
        #잘못된 카테고리가 들어왔을 때
        is_exist = await check_category_exist(user.user_id,
                                              reg_info.category_id)
        if not is_exist:
            return JSONResponse(status_code=400,
                                content=dict(msg="잘못된 접근입니다."))
        Posts.create(
            session=session,
            auto_commit=True,
            **reg_info.dict(exclude={"post_body"}),
            user_id=user.user_id,
        )
        PostBody.create(
            session=session,
            auto_commit=True,
            post_body=reg_info.post_body,
            post_id=Posts.filter().order_by("-post_id").first().post_id)

    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.patch("/post")
async def update_post(request: Request, update_info: m.PostUpdate):
    """
    개시물 수정
    """
    try:
        user = request.state.user
        #잘못된 카테고리가 들어왔을 때
        if update_info.category_id is not None:
            is_exist = await check_category_exist(user.user_id,
                                                  update_info.category_id)
            if not is_exist:
                return JSONResponse(status_code=400,
                                    content=dict(msg="잘못된 접근입니다."))
        Posts.filter(user_id=user.user_id, post_id=update_info.post_id).update(
            auto_commit=True,
            **update_info.dict(
                exclude={"post_body", "post_id"},
                exclude_unset=True,
            ))
        PostBody.filter(post_id=update_info.post_id).update(
            auto_commit=True, post_body=update_info.post_body)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.delete("/post/{post_id}")
async def delete_post(request: Request, post_id: int):
    """
    게시물 삭제
    """
    try:
        user = request.state.user
        Posts.filter(user_id=user.user_id,
                     post_id=post_id).delete(auto_commit=True)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


#유저 카테고리 체크
async def check_category_exist(user_id: int, category_id: int):
    user_category_list = []
    usercategorys = Categories.filter(user_id=user_id).all()
    for usercategory in usercategorys:
        user_category_list.append(usercategory.category_id)
    if category_id not in user_category_list:
        return False
    return True


"""
Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX25hbWUiOiJ0ZXN0MSIsImVtYWlsIjoidGVzdDFAZXhhbXBsZS5jb20iLCJwaG9uZV9udW0iOiIwMTAtMTIzNC01Njc4IiwicmVzaWRlbmNlIjoidGVzdDEifQ.cQxXGyub-7d3UARj68yTHiXHGNW9mNgGHJ-dseSfMI4
Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VyX25hbWUiOiJ0ZXN0MiIsImVtYWlsIjoidGVzdDJAZXhhbXBsZS5jb20iLCJwaG9uZV9udW0iOiIwMTAtMTIzNC01Njc4IiwicmVzaWRlbmNlIjoidGVzdDIifQ.A4rh2jqRQtPURjUJlpdG5Nikh0KqNQjnRwoAKpXew3w
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