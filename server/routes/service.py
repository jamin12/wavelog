from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from starlette.requests import Request
from fastapi import APIRouter
from typing import List
from inspect import currentframe as frame

import model as m
from database.schema import Users, UserCatagory

router = APIRouter()


@router.get("/", response_model=List[m.GetUserList])
async def splash():
    """
    ELB 상태 체크용 API
    :return:
    """
    all_users = Users.filter().all()
    return all_users


@router.get("/index", response_model=List[m.Mainpage])
async def index():
    all_users_catagory = UserCatagory.filter()._q
    outputlist = []
    outputdict = {}
    for i in all_users_catagory:
        outputdict["catagory_name"] = i.catagory_name
        outputdict["catagory_color"] = i.catagory_color
        outputdict["user_name"] = i.user.user_name
        outputlist.append(outputdict.copy())
    return outputlist


@router.get("/post", response_model=List[m.GetPostList], status_code=200)
async def get_post(request: Request):
    try:
        user_post = UserPosts.filter()._q
        user_post_list = []
        user_post_dict = {}
        for i in user_post:
            user_post_dict["post_title"] = i.posts.post_title
            user_post_dict["catagory_id"] = i.user_catagory.id
            user_post_dict["user_id"] = i.user_catagory.user_id
            user_post_list.append(user_post_dict.copy())
    except Exception as e:
        request.state.inspect = frame()
        raise e
    return user_post_list
