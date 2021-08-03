from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from starlette.responses import JSONResponse
from starlette.requests import Request
from fastapi import APIRouter
from typing import List
from inspect import currentframe as frame
from fastapi.param_functions import Depends
import bcrypt

import model as m
from database.schema import *
from database.conn import db

router = APIRouter(prefix="/service")
category_list = []


@router.get("/{user_id}")
async def splash(request: Request, user_id: int):
    """
    ELB 상태 체크용 API
    :return:
    """
    try:
        global category_list
        category_list = Categories.filter(user_id=user_id).all()
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


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
    게시판 불러오기
    """
    try:
        global category_list
        if category_id == 0:
            post = Posts.filter(user_id=user_id).all()
            return post + category_list
        if not await check_category_exist(user_id, category_id):
            return JSONResponse(status_code=404,
                                content=dict(msg="page not found"))
        post = Posts.filter(user_id=user_id, category_id=category_id).all()
        return post + category_list
    except Exception as e:
        request.state.inspect = frame()
        raise e


#게시물
@router.get("/getpost/{user_id}/{post_id}", response_model=m.GetPost)
async def get_post(request: Request, user_id: int, post_id: int):
    """
    게시물 불러오기
    """
    try:
        comment_body = []
        if Posts.filter(post_id=post_id).first() is None:
            return JSONResponse(status_code=404,
                                content=dict(msg="page not found"))
        post = Posts.get(user_id=user_id, post_id=post_id)
        post_body = PostBody.get(post_id=post_id)
        comments = Comment.filter(post_id=post_id).all()
        for comment in comments:
            comment_body.append(comment.comment_body)
        return {
            "post_title": post.post_title,
            "post_body": post_body.post_body,
            "comment": comment_body
        }
    except Exception as e:
        request.state.inspect = frame()
        raise e


@router.post("/comment", status_code=201)
async def create_comment(request: Request,
                         reg_info: m.CommentRegister,
                         session: Session = Depends(db.session)):
    """
    댓글 달기
    """
    try:
        hash_pw = bcrypt.hashpw(reg_info.password.encode("utf-8"),
                                bcrypt.gensalt())
        Comment.create(
            session=session,
            auto_commit=True,
            **reg_info.dict(exclude={"password"}),
            password=hash_pw,
        )
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.patch("/comment/{comment_id}/{password}/{change_comment}")
async def update_comment(request: Request, comment_id: int, password: str,
                         change_comment: str):
    """
    댓글 수정
    """
    try:
        comment_info = Comment.get(comment_id=comment_id)
        is_verified = bcrypt.checkpw(password.encode("utf-8"),
                                     comment_info.password.encode("utf-8"))
        if not is_verified:
            return JSONResponse(status_code=400,
                                content=dict(msg="please check password"))
        else:
            Comment.filter(comment_id=comment_id).update(
                auto_commit=True, comment_body=change_comment)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


@router.delete("/comment/{comment_id}/{password}")
async def delete_comment(request: Request, comment_id: int, password: str):
    """
    댓글 삭제
    """
    try:
        comment_info = Comment.get(comment_id=comment_id)
        is_verified = bcrypt.checkpw(password.encode("utf-8"),
                                     comment_info.password.encode("utf-8"))
        #비밀 번호가 틀렸을 때
        if not is_verified:
            return JSONResponse(status_code=400,
                                content=dict(msg="please check password"))
        else:
            Comment.filter(comment_id=comment_id).delete(auto_commit=True)
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return m.MessageOk()


async def check_category_exist(user_id: int, category_id: int):
    """
    유저 카테고리 체크
    :param user_id : int :
    :param category_id : int :
    :return bool:
    """
    user_category_list = []
    usercategorys = Categories.filter(user_id=user_id).all()
    for usercategory in usercategorys:
        user_category_list.append(usercategory.category_id)
    if category_id not in user_category_list:
        return False
    return True