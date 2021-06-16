from os import path as op
from sys import path as sp

sp.append(op.dirname(__file__))

from dataclasses import asdict

import uvicorn
from fastapi import FastAPI, Depends
from fastapi.security import APIKeyHeader
from starlette.middleware.cors import CORSMiddleware
from starlette.middleware.base import BaseHTTPMiddleware

from common.config import conf
from database.conn import db, Base
from routes import index, auth
from middlewares.trusted_hosts import TrustedHostMiddleware
from middlewares.token_validator import access_control

API_KEY_HEADER = APIKeyHeader(name="Authorization", auto_error=False)


def create_app():
    """
    앱 함수 실행
    :return:
    """
    c = conf()
    app = FastAPI()
    conf_dict = asdict(c)
    db.init_app(app, **conf_dict)
    # 데이터 베이스 이니셜라이즈

    # 레디스 이니셜라이즈

    # 미들웨어 정의
    app.add_middleware(middleware_class=BaseHTTPMiddleware,
                       dispatch=access_control)
    app.add_middleware(
        CORSMiddleware,
        allow_origins=conf().ALLOW_SITE,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    app.add_middleware(TrustedHostMiddleware,
                       allowed_hosts=conf().TRUSTED_HOSTS,
                       except_path=["/health"])
    # 라우터 정의
    app.include_router(index.router)
    app.include_router(auth.router, tags=["Authentication"], prefix="/api")
    return app


app = create_app()

if __name__ == "__main__":
    uvicorn.run("main:app", host='127.0.0.1', port=8080, reload=True)