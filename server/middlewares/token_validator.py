from os import path as op
from sys import path as sp

from sqlalchemy.orm import session

sp.append(op.dirname(op.dirname(__file__)))

import PIL.Image as pilimg
import time
import jwt
import re

import sqlalchemy.exc
from jwt.exceptions import ExpiredSignatureError, DecodeError

from starlette.requests import Request
from starlette.responses import JSONResponse

from utils.date_utils import D
from utils.logger import api_logger
from common.consts import EXCEPT_PATH_LIST, EXCEPT_PATH_REGEX, JWT_ALGORITHM, JWT_SECRET
from errors import exceptions as ex
from database.schema import db
import model as m


async def access_control(request: Request, call_next):
    request.state.req_time = D.datetime()
    request.state.start = time.time()
    #에러 로깅 변수
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

    #url 패턴 체크
    if await url_pattern_check(url,
                               EXCEPT_PATH_REGEX) or url in EXCEPT_PATH_LIST:
        response = await call_next(request)
        if url != '/':
            await api_logger(request=request, response=response)
        return response

    try:
        if url.startswith('/favicon.ico'):
            raise ex.SqlFailureEx()
        if url.startswith('/api/useract'):
            #토큰 체크
            if "authorization" in headers.keys():
                token_info = await token_decode(headers.get("Authorization"))
                print(token_info)
                request.state.user = m.UserToken(**token_info)
                # qs = str(request.query_params)
                # qs_list = qs.split("&")
                response = await call_next(request)
                return response

            else:
                raise ex.NotAuthorized()

    except Exception as e:
        error = await exception_handler(e)
        error_dict = dict(status=error.status_code,
                          msg=error.msg,
                          detail=error.detail,
                          code=error.code)
        response = JSONResponse(status_code=error.status_code,
                                content=error_dict)
        await api_logger(request=request, error=error)
    return response


async def url_pattern_check(path, pattern):
    result = re.match(pattern, path)
    if result:
        return True
    return False


async def exception_handler(error: Exception):
    if isinstance(error, sqlalchemy.exc.OperationalError):
        error = ex.SqlFailureEx(ex=error)
    if not isinstance(error, ex.APIException):
        error = ex.APIException(ex=error, detail=str(error))
    return error


async def token_decode(access_token):
    """
    :param access_token:
    :return:
    """
    try:
        access_token = access_token.replace("Bearer ", "")
        payload = jwt.decode(access_token,
                             key=JWT_SECRET,
                             algorithms=[JWT_ALGORITHM])
    except ExpiredSignatureError:
        raise ex.TokenExpiredEx()
    except DecodeError:
        raise ex.TokenDecodeEx()
    return payload