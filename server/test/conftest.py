import os
from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from typing import List

import bcrypt
import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from database.schema import Users
from main import create_app
from database.conn import db, Base
from model import UserToken
from routes.auth import create_access_token
from utils.logger import t_api_logger


@pytest.fixture(scope="session")
def app():
    os.environ["API_ENV"] = "test"
    return create_app()


@pytest.fixture(scope="session")
def client(app):
    # Create tables
    Base.metadata.create_all(db.engine)
    return TestClient(app=app)


@pytest.fixture(scope="function")
def session():
    sess = next(db.session())
    yield sess
    clear_all_table_data(
        session=sess,
        metadata=Base.metadata,
        except_tables=[],
    )
    sess.rollback()


@pytest.fixture(scope="function")
def login(session):
    """
    테스트전 사용자 미리 등록
    :param session:
    :return:
    """
    hash_pw = bcrypt.hashpw("qwer1234".encode("utf-8"), bcrypt.gensalt())
    db_user = Users.create(session=session, user_name="test", password=hash_pw)
    session.commit()
    access_token = create_access_token(
        data=UserToken.from_orm(db_user).dict(exclude={'password'}), )
    return dict(Authorization=f"Bearer {access_token}")


def clear_all_table_data(session: Session,
                         metadata,
                         except_tables: List[str] = None):
    session.execute("SET FOREIGN_KEY_CHECKS = 0;")
    for table in metadata.sorted_tables:
        if table.name not in except_tables:
            session.execute(table.delete())
    session.execute("SET FOREIGN_KEY_CHECKS = 1;")
    session.commit()
