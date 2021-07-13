from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from starlette.responses import JSONResponse
from starlette.requests import Request
from fastapi import APIRouter
from typing import List
from inspect import currentframe as frame

import model as m
from database.schema import Users

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
