from enum import auto
from os import path as op
from sys import path as sp
from typing import List

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter
from fastapi.param_functions import Depends
from sqlalchemy.orm.session import Session
from inspect import currentframe as frame

from starlette.requests import Request

from database.schema import *
import model as m
from errors.exceptions import TokenDecodeEx

router = APIRouter(prefix="/useract")


@router.get("/me", response_model=m.UserToken)
async def get_me(request: Request):
    user = request.state.user
    user_info = Users.get(id=user.id)
    return user_info


@router.put("/me/{myname}")
async def put_me(request: Request, my_name: str):
    user = request.state.user
    me = Users.filter(id=user.id)
    if me:
        me.update(auto_commit=True, user_name=my_name)

    return m.MessageOk()


@router.delete("/me")
async def delete_me(request: Request):
    user = request.state.user
    Users.filter(id=user.id).delete(auto_commit=True)

    return m.MessageOk()


@router.get('/catagory', response_model=List[m.CatagoryList])
async def get_catagory(request: Request):
    """
    내 카테고리
    """
    try:

        user = request.state.user
        my_catagory = UserCatagory.filter(user_id=user.id).all()

    except Exception as e:
        request.state.inspect = frame()
        raise e
    return my_catagory


@router.post('/catagory', status_code=201)
async def create_catagory(request: Request,
                          catagory_info: m.CatagoryRegister,
                          session: Session = Depends(db.session)):
    """
    카테고리 생성
    """
    user = request.state.user
    UserCatagory.create(session=session,
                        auto_commit=True,
                        user_id=user.id,
                        **catagory_info.dict())
    return m.MessageOk()


"""
TODO
색 변경 하기-> 색이 있을까? 이제?
"""


@router.put('/catagory/{catagory_id}/{catagoryrename}')
async def put_catagory(request: Request, catagory_id: int,
                       catagory_rename: str):
    """
    카테고리 이름 변경
    """
    try:
        user = request.state.user
        UserCatagory.filter(user_id=user.id, id=catagory_id).update(
            auto_commit=True, catagory_name=catagory_rename)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.delete('/catagory/{catagory_id}}')
async def delete_catagory(request: Request, catagory_id: int):
    try:
        user = request.state.user
        UserCatagory.filter(id=catagory_id,
                            user_id=user.id).delete(auto_commit=True)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.post('/post', status_code=201)
async def create_post(request: Request,
                      reg_info: m.PostRegister,
                      session: Session = Depends(db.session)):
    try:
        user = request.state.user
        catagory_list = []
        for i in UserCatagory.filter(user_id=user.id).all():
            catagory_list.append(i.id)

        if reg_info.catagory_id not in catagory_list:
            raise TokenDecodeEx

        Posts.create(
            session=session,
            auto_commit=True,
            **reg_info.dict(exclude={'post_body'}),
        )

        PostBody.create(
            session=session,
            auto_commit=True,
            post_id=Posts.filter().order_by("-id").first().id,
            post_body=reg_info.post_body,
        )
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


"""
Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidXNlcl9uYW1lIjoidGVzdDEiLCJlbWFpbCI6InRlc3QxQGV4YW1wbGUuY29tIiwicGhvbmVfbnVtIjoiMDEwLTEyMzQtNTY3OCIsInJlc2lkZW5jZSI6InRlc3QxIn0.gFvOGD7fW3HRcqYV2026VL1ZuWiskQAVtuJW3gjYciM
Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MiwidXNlcl9uYW1lIjoidGVzdDIiLCJlbWFpbCI6InRlc3QyQGV4YW1wbGUuY29tIiwicGhvbmVfbnVtIjoiMDEwLTEyMzQtNTY3OCIsInJlc2lkZW5jZSI6InRlc3QyIn0.J0SUmtYYx57ZGongUL1DIhDmvqiKEDTFjutKgwnD9U8
"""