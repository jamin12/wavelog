from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter
from typing import List

from model import GetUserList
from database.schema import Users

router = APIRouter()


@router.get("/", response_model=List[GetUserList])
async def index():
    """
    ELB 상태 체크용 API
    :return:
    """
    all_users = Users.filter().all()
    return all_users
