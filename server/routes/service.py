from os import path as op
from sys import path as sp
from pydantic.errors import JsonError
from sqlalchemy.sql.functions import user

sp.append(op.dirname(op.dirname(__file__)))

from starlette.responses import JSONResponse
from starlette.requests import Request
from fastapi import APIRouter
from typing import List
from inspect import currentframe as frame

import model as m
from database.schema import *

router = APIRouter()


@router.get("/", response_model=List[m.GetUserList])
async def splash(request: Request):
    """
    ELB 상태 체크용 API
    :return:
    """
    try:
        all_users = Users.filter().all()
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return all_users


@router.get('/about/{user_name}', response_model=m.UserToken)
async def about(request: Request, user_name: str):
    """
    about 페이지
    """
    try:
        me = Users.get(user_name=user_name)
        if me is None:
            return JSONResponse(status_code=404,
                                content=dict(msg="page not found"))
        return me
    except Exception as e:
        request.state.inspect = frame()
        raise e


#게시판
@router.get("/contents/{user_id}/{category_id}",
            response_model=List[m.contents],
            response_model_exclude_unset=True)
async def contents(request: Request, user_id: int, category_id: int):
    """
    TODO 카테고리를 매번 불러와야하나?? 
    """
    try:
        if category_id == 0:
            post = Posts.filter(user_id=user_id).all()
            category = Categories.filter(user_id=user_id).all()
            response = post + category
            return response
        post = Posts.filter(user_id=user_id, category_id=category_id).all()
        category = Categories.filter(user_id=user_id).all()
        response = post + category
        return response
    except Exception as e:
        request.state.inspect = frame()
        raise e


#게시물
@router.get("/getpost/{user_id}/{post_id}", response_model=m.GetPost)
async def get_post(request: Request, user_id: int, post_id: int):
    try:
        if Posts.filter(post_id=post_id).first() is None:
            return JSONResponse(status_code=404,
                                content=dict(msg="page not found"))
        post = Posts.get(user_id=user_id, post_id=post_id)
        return post
    except Exception as e:
        request.state.inspect = frame()
        raise e