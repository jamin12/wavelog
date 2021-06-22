from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter
from typing import List

from model import GetUserList, Mainpage
from database.schema import Users, UserCatagory

router = APIRouter()


@router.get("/", response_model=List[GetUserList])
async def splash():
    """
    ELB 상태 체크용 API
    :return:
    """
    all_users = Users.filter().all()
    return all_users


@router.get("/index", response_model=List[Mainpage])
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