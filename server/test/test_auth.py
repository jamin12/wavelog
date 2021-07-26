from database.schema import Users
from utils.logger import t_api_logger


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
    t_api_logger(response=res_body)
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
    t_api_logger(response=res_body)
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
    t_api_logger(response=res_body)
    assert res.status_code == 400
    assert "USER_EXISTS" == res_body["msg"]


def test_user_login(client, login):
    """
    "로그인"
    :param client:
    :param login:
    """
    logins = dict(user_name="test", password="qwer1234")
    res = client.post("/blog/auth/login", json=logins)
    res_body = res.json()
    t_api_logger(response=res_body)
    assert res.status_code == 200
    assert "Authorization" in res_body
    assert login == res_body


def test_user_login_check_param(client, login):
    logins = dict(user_name="test")
    res = client.post("/blog/auth/login", json=logins)
    res_body = res.json()
    t_api_logger(response=res_body)
    assert res.status_code == 400
    assert "user_name or password must be provided" == res_body["msg"]


def test_user_login_match_user(client, login):
    logins = dict(user_name="test1", password="qwer1234")
    res = client.post("/blog/auth/login", json=logins)
    res_body = res.json()
    t_api_logger(response=res_body, login=login)
    assert res.status_code == 400
    assert "No Match User" == res_body["msg"]


def test_user_login_faild_password(client, login):
    logins = dict(user_name="test", password="qwer123q4q")
    res = client.post("/blog/auth/login", json=logins)
    res_body = res.json()
    t_api_logger(response=res_body, login=login["Authorization"])
    assert res.status_code == 400
    assert "user_name or password must be provided" == res_body["msg"]