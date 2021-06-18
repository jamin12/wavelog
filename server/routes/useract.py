from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter, requests
from fastapi.param_functions import Depends
from sqlalchemy.orm.session import Session

from starlette.requests import Request

from database.schema import db, UsersCatagory

router = APIRouter(prefix="/useract")


@router.post('/catagory_register')
async def register(request: Request, session: Session = Depends(db.session)):
    """
    카테고리 생성
    """
    user = request.state.user

    new_catagory = UsersCatagory.create(session,
                                        auto_commit=True,
                                        user_id=user.id,
                                        catagory_name=...)
