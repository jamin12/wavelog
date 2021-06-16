from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from fastapi import APIRouter

router = APIRouter(prefix="/useract")
