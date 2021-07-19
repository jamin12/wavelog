from os import path as op
from sys import path as sp
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
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return me


@router.get("/contents/{user_id}/{category_id}",
            response_model=List[m.contents],
            response_model_exclude_unset=True)
async def contents(request: Request, user_id: int, category_id: int):
    try:
        post = Posts.filter(user_id=user_id)._q
        category = Categories.filter(user_id=user_id)._q
        a = post.outerjoin(Categories,
                           Posts.user_id == Categories.user_id).all()
        print(a[0].categoty_name)
        return a
        # if category_id == 0:
        #     Posts.filter(user_id=user_id).all()
    except Exception as e:
        request.state.inspect = frame()
        raise e