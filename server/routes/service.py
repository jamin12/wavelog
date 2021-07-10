from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from starlette.responses import JSONResponse
from starlette.requests import Request
from fastapi import APIRouter
from typing import List
from inspect import currentframe as frame

import model as m
from database.schema import Users, UserCatagory, Posts

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
    try:
        me = Users.get(user_name=user_name)
        if me is None:
            return JSONResponse(status_code=404,
                                content=dict(msg="page not found"))
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return me


@router.get('/noticeboard/{user_id}/{catagory_id}')
async def noticeboard(request: Request, user_id: int, catagory_id: int):
    try:
        my_catagory = UserCatagory.filter(user_id=user_id).all()
        my_catagory_list = [i.id for i in my_catagory]
        if catagory_id not in my_catagory_list:
            return JSONResponse(status_code=404,
                                content=dict(msg="잘못된 접근입니다."))
        if catagory_id == 0:
            my_post = Posts.filter().all()
        my_post = Posts.filter(catagory_id=catagory_id).all()
        print(my_post, end="\n\n\n\n\n\n\n\n\n\n\n")
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()
