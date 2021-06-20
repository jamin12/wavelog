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
    all_users = Users.filter(id__gt=0)
    # print(all_users[0].user_catagory[0])
    print(all_users.user_name)
    # return all_users


@router.get("/index", response_model=List[Mainpage])
async def index():
    all_users_catagory = UserCatagory.filter().all()
    print(all_users_catagory[0].user)