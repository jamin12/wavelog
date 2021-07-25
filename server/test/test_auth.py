import json
import logging
from fastapi.logger import logger
from database.schema import Users

logger.setLevel(logging.INFO)


def test_user_registration(client, session):
    """
    "유저 생성"
    :param client:
    :param session:
    :return:
    """
    user = dict(user_name="test1", password="123")
    res = client.post("/blog/auth/register", json=user)
    res_body = res.json()
    a = dict(res_body=res_body)
    logger.info(json.dumps(a))
    assert res.status_code == 201


def test_user_registration_check_param(client, session):
    """
    "유저 생성"
    :param client:
    :param session:
    :return:
    """
    user = dict(user_name="test1")
    res = client.post("/blog/auth/register", json=user)
    res_body = res.json()
    print(res_body)
    assert res.status_code == 400
    assert "user name and password must be provided" == res_body["msg"]


def test_user_registration_exist_user(client, session):
    """
    "유저 생성"
    :param client:
    :param session:
    :return:
    """
    user = dict(user_name="test1", password="123")
    Users.create(session=session, **user)
    session.commit()
    res = client.post("/blog/auth/register", json=user)
    res_body = res.json()
    print(res_body)
    assert res.status_code == 400
    assert "USER_EXISTS" == res_body["msg"]