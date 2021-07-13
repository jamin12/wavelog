from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter
from starlette.requests import Request
from inspect import currentframe as frame
from fastapi.param_functions import Depends

from database.schema import *
import model as m

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


"""
TODO 카테고리 이름 중복으로 들어가는거 맘에 안드는데... 어캐 고칠지 생각즁.
"""


@router.post("/Catagory", status_code=201)
async def create_catagory(request: Request,
                          reg_info: m.CategoryRegister,
                          session: Session = Depends(db.session)):
    user = request.state.user
    try:
        Categories.create(session=session, auto_commit=True, **reg_info.dict())
        UserCategory.create(
            session=session,
            auto_commit=True,
            user_id=user.id,
            category_id=Categories.filter(
                category_name=reg_info.category_name).first().id)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


"""
Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidXNlcl9uYW1lIjoidGVzdDEiLCJlbWFpbCI6InRlc3QxQGV4YW1wbGUuY29tIiwicGhvbmVfbnVtIjoiMDEwLTEyMzQtNTY3OCIsInJlc2lkZW5jZSI6InRlc3QxIn0.gFvOGD7fW3HRcqYV2026VL1ZuWiskQAVtuJW3gjYciM
Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MiwidXNlcl9uYW1lIjoidGVzdDIiLCJlbWFpbCI6InRlc3QyQGV4YW1wbGUuY29tIiwicGhvbmVfbnVtIjoiMDEwLTEyMzQtNTY3OCIsInJlc2lkZW5jZSI6InRlc3QyIn0.J0SUmtYYx57ZGongUL1DIhDmvqiKEDTFjutKgwnD9U8
"""