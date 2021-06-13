from datetime import datetime

from fastapi import APIRouter
from starlette.requests import Request
from starlette.responses import Response
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
    all_users = Users.all()
    return all_users
