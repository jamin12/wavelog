from datetime import datetime
from enum import Enum

from pydantic import Field
from pydantic.main import BaseModel
from pydantic.networks import EmailStr, IPvAnyAddress


class UserRegister(BaseModel):
    # pip install 'pydantic[email]'
    user_name: str = None
    pw: str = None