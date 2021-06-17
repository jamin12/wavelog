from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter

router = APIRouter(prefix="/useract")


@router.post('/catagory_register')
async def register():
    """
    카테고리 생성
    """
    ...