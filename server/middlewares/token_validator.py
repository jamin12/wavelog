from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

import time

import re

import sqlalchemy.exc

from starlette.requests import Request

from utils.date_utils import D
from utils.logger import api_logger
from common.consts import EXCEPT_PATH_LIST, EXCEPT_PATH_REGEX
from errors.exceptions import APIException, SqlFailureEx


async def access_control(request: Request, call_next):
    request.state.req_time = D.datetime()
    request.state.start = time.time()
    request.state.inspect = None
    request.state.user = None
    request.state.service = None

    ip = request.headers[
        "x-forwarded-for"] if "x-forwarded-for" in request.headers.keys(
        ) else request.client.host
    request.state.ip = ip.split(",")[0] if "," in ip else ip
    headers = request.headers
    cookies = request.cookies

    url = request.url.path
    if await url_pattern_check(url,
                               EXCEPT_PATH_REGEX) or url in EXCEPT_PATH_LIST:
        response = await call_next(request)
        await api_logger(request=request, response=response)
        return response


async def url_pattern_check(path, pattern):
    result = re.match(pattern, path)
    if result:
        return True
    return False


async def exception_handler(error: Exception):
    print(error)
    if isinstance(error, sqlalchemy.exc.OperationalError):
        error = SqlFailureEx(ex=error)
    if not isinstance(error, APIException):
        error = APIException(ex=error, detail=str(error))
    return error
