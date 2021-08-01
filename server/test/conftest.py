import os
from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from typing import List

import bcrypt
import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from database.schema import Users, Categories, Posts, PostBody, Comment
from main import create_app
from database.conn import db, Base
from model import UserToken
from routes.auth import create_access_token


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


"""
TODO 아니 이거 계속 세션 받아오고 해야하나??
상위개체 받아오고 사용할수 없남/.
"""


@pytest.fixture(scope="function")
def category(session):
    """
    테스트전 카테고리 미리 등록
    :param session:
    """
    user = Users.get(user_name="test")
    Categories.create(session=session,
                      user_id=user.user_id,
                      category_name="test_category")
    session.commit()


@pytest.fixture(scope="function")
def post(session):
    """
    테스트전 게시물 미리 등록
    """
    user = Users.get(user_name="test")
    category = Categories.get(category_name="test_category")
    Posts.create(session=session,
                 auto_commit=True,
                 user_id=user.user_id,
                 post_title="test_title",
                 category_id=category.category_id)
    PostBody.create(
        session=session,
        auto_commit=True,
        post_body="test_body",
        post_id=Posts.filter().order_by("-post_id").first().post_id)


@pytest.fixture(scope="function")
def comment(session):
    """
    테스트전 댓글 미리 등록
    """
    hash_pw = bcrypt.hashpw("qwer1234".encode("utf-8"), bcrypt.gensalt())
    post = Posts.get(post_id=1)
    Comment.create(session=session,
                   post_id=post.post_id,
                   nick_name="test_nick_name",
                   password=hash_pw,
                   comment_body="test_comment_body")
    Comment.create(session=session,
                   post_id=post.post_id,
                   nick_name="test_nick_name2",
                   password=hash_pw,
                   comment_body="test_comment_body2")
    session.commit()


def clear_all_table_data(session: Session,
                         metadata,
                         except_tables: List[str] = None):
    session.execute("SET FOREIGN_KEY_CHECKS = 0;")
    for table in metadata.sorted_tables:
        if table.name not in except_tables:
            session.execute(table.delete())
    session.execute("SET FOREIGN_KEY_CHECKS = 1;")
    session.commit()
