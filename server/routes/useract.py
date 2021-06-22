from os import path as op
from sys import path as sp
from typing import List

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter
from fastapi.param_functions import Depends
from sqlalchemy.orm.session import Session

from starlette.requests import Request

from database.schema import db, UserCatagory, Users
from model import CatagoryRegister, CatagoryDelete, MessageOk, UserOut, CatagoryList

router = APIRouter(prefix="/useract")


@router.get("/me", response_model=UserOut)
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

    return MessageOk()


@router.delete("/me")
async def delete_me(request: Request):
    user = request.state.user
    Users.filter(id=user.id).delete(auto_commit=True)

    return MessageOk()


@router.get('/catagory', response_model=List[CatagoryList])
async def get_catagory(request: Request):
    """
    내 카테고리
    """
    user = request.state.user
    my_catagory = UserCatagory.filter(user_id=user.id).all()
    return my_catagory


@router.post('/catagory', status_code=201)
async def create_catagory(request: Request,
                          catagory_info: CatagoryRegister,
                          session: Session = Depends(db.session)):
    """
    카테고리 생성
    """
    user = request.state.user
    UserCatagory.create(session=session,
                        auto_commit=True,
                        user_id=user.id,
                        **catagory_info.dict())
    return MessageOk()


@router.put('/catagory/{catagoryname}/{catagoryrename}')
async def put_catagory(request: Request, catagory_name: str,
                       catagory_rename: str):
    """
    카테고리 이름 변경
    """
    user = request.state.user
    UserCatagory.filter(user_id=user.id, catagory_name=catagory_name).update(
        auto_commit=True, catagory_name=catagory_rename)
    return MessageOk()


@router.delete('/catagory/{CatagoryName}')
async def delete_catagory(request: Request, catagory_name: str):
    user = request.state.user
    UserCatagory.filter(catagory_name=catagory_name,
                        user_id=user.id).delete(auto_commit=True)

    return MessageOk()
