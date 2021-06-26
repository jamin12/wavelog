from os import path as op
from sys import path as sp
from typing import List

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter
from fastapi.param_functions import Depends
from sqlalchemy.orm.session import Session
from inspect import currentframe as frame

from starlette.requests import Request

from database.schema import db, UserCatagory, Users, UserPosts
import model as m

router = APIRouter(prefix="/useract")


@router.get("/me", response_model=m.UserOut)
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
        request.state.inspect = frame
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


@router.put('/catagory/{catagoryname}/{catagoryrename}')
async def put_catagory(request: Request, catagory_name: str,
                       catagory_rename: str):
    """
    카테고리 이름 변경
    """
    user = request.state.user
    UserCatagory.filter(user_id=user.id, catagory_name=catagory_name).update(
        auto_commit=True, catagory_name=catagory_rename)
    return m.MessageOk()


@router.delete('/catagory/{CatagoryName}')
async def delete_catagory(request: Request, catagory_name: str):
    try:
        user = request.state.user
        UserCatagory.filter(catagory_name=catagory_name,
                            user_id=user.d).delete(auto_commit=True)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.post("/post", status_code=201)
async def create_post(request: Request,
                      post_info: m.PostRegister,
                      session: Session = Depends(db.session)):
    """
    게시물 생성
    """
    user = request.state.user
    UserPosts.create(session=session, auto_commit=True, **post_info)
