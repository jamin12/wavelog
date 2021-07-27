from utils.logger import t_api_logger
from database.schema import Users, Categories


def test_category_register(client, login):
    """
    카테고리 생성
    :param client:
    :param login:
    """
    url = "/blog/useract/category"
    user = Users.get(user_name="test")
    category = dict(user_id=user.user_id, category_name="test_category")
    res = client.post(url,
                      json=category,
                      headers=dict(Authorization=login["Authorization"]))
    t_api_logger(response=res, url=url)
    assert res.status_code == 201


def test_category_update(client, login, category):
    """
    카테고리 수정
    :param client:
    :param login:
    """
    user = Users.get(user_name="test")
    category = Categories.get(category_name="test_category")
    rename = "test_category_rename"
    url = f"/blog/useract/category/{user.user_id}/{category.category_id}/{rename}"
    res = client.put(url, headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 user_id=user.user_id,
                 category_id=category.category_id)
    assert res.status_code == 200


def test_category_update_wrong_catgory(client, login, category):
    """
    카테고리 수정, 잘못된 카테고리가 들어왔을 때
    :param client:
    :param login:
    :param category:
    """
    user = Users.get(user_name="test")
    category = Categories.get(category_name="test_category")
    rename = "test_category_rename"
    url = f"/blog/useract/category/{user.user_id}/{category.category_id+20000}/{rename}"
    res = client.put(url, headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 user_id=user.user_id,
                 category_id=category.category_id)
    assert res.status_code == 400
    assert "잘못된 접근입니다." == res.json()["msg"]