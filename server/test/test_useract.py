from utils.logger import t_api_logger
from database.schema import Users, Categories, Posts

prefix_url = "/blog/useract"


def test_category_register(client, login):
    """
    카테고리 생성
    """
    url = prefix_url + "/category"
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
    """
    user = Users.get(user_name="test")
    category = Categories.get(category_name="test_category")
    rename = "test_category_rename"
    url = prefix_url + f"/category/{user.user_id}/{category.category_id}/{rename}"
    res = client.put(url, headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 user_id=user.user_id,
                 category_id=category.category_id)
    assert res.status_code == 200


def test_category_update_wrong_catgory(client, login, category):
    """
    카테고리 수정, 잘못된 카테고리가 들어왔을 때
    """
    user = Users.get(user_name="test")
    category = Categories.get(category_name="test_category")
    rename = "test_category_rename"
    url = prefix_url + f"/category/{user.user_id}/{category.category_id+20000}/{rename}"
    res = client.put(url, headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 user_id=user.user_id,
                 category_id=category.category_id)
    assert res.status_code == 400
    assert "잘못된 접근입니다." == res.json()["msg"]


def test_category_update_wrong_user(client, login, category):
    """
    카테고리 수정, 잘못된 유저가 입력 됐을 때
    """
    user = Users.get(user_name="test")
    category = Categories.get(category_name="test_category")
    rename = "test_category_rename"
    url = prefix_url + f"/category/{user.user_id+1}/{category.category_id}/{rename}"
    res = client.put(url, headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 user_id=user.user_id,
                 category_id=category.category_id)
    assert res.status_code == 400
    assert "잘못된 접근입니다." == res.json()["msg"]


def test_category_delete(client, login, category):
    """
    카테고리 삭제
    """
    user = Users.get(user_name="test")
    category = Categories.get(category_name="test_category")
    url = prefix_url + f"/category/{user.user_id}/{category.category_id}"
    res = client.delete(url,
                        headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 user_id=user.user_id,
                 category_id=category.category_id)
    assert res.status_code == 200


def test_category_delete_wrong_category(client, login, category):
    """ 
    카테고리 삭제, 잘못된 카테고리가 들어왔을 때
    """
    user = Users.get(user_name="test")
    category = Categories.get(category_name="test_category")
    url = prefix_url + f"/category/{user.user_id}/{category.category_id+200}"
    res = client.delete(url,
                        headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 user_id=user.user_id,
                 category_id=category.category_id)
    assert res.status_code == 400
    assert "잘못된 접근입니다." == res.json()["msg"]


def test_category_delete_wrong_user(client, login, category):
    """ 
    카테고리 삭제, 잘못된 유저가 입력됐을 때
    """
    user = Users.get(user_name="test")
    category = Categories.get(category_name="test_category")
    url = prefix_url + f"/category/{user.user_id+1}/{category.category_id}"
    res = client.delete(url,
                        headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 user_id=user.user_id,
                 category_id=category.category_id)
    assert res.status_code == 400
    assert "잘못된 접근입니다." == res.json()["msg"]


def test_post_register(client, login, category):
    """
    게시물 생성
    """
    category = Categories.get(category_name="test_category")
    post = dict(post_title="test_title",
                post_body="test_body",
                category_id=category.category_id)
    url = prefix_url + f"/post"
    res = client.post(url,
                      json=post,
                      headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 post=post,
                 category_id=category.category_id)
    assert res.status_code == 201


def test_post_register_wrong_category(client, login, category):
    """
    게시물 생성, 잘못된 카테고리가 들어왔을 때
    """
    category = Categories.get(category_name="test_category")
    post = dict(
        post_title="test_title",
        post_body="test_body",
        category_id=category.category_id + 1,
    )
    url = prefix_url + f"/post"
    res = client.post(url,
                      json=post,
                      headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 post=post,
                 category_id=category.category_id)
    assert res.status_code == 400
    assert "잘못된 접근입니다." == res.json()["msg"]


def test_post_update(client, login, category, post):
    """
    게시물 수정
    """
    category = Categories.get(category_name="test_category")
    post = dict(post_id=1,
                post_title="test_title",
                post_body="test_body",
                category_id=category.category_id)
    url = prefix_url + f"/post"
    res = client.patch(url,
                       json=post,
                       headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 post=post,
                 category_id=category.category_id)
    assert res.status_code == 200


def test_post_update_wrong_category(client, login, category):
    """
    게시물 수정, 잘못된 카테고리가 들어왔을 때
    """
    category = Categories.get(category_name="test_category")
    post = dict(
        post_id=1,
        post_title="test_title",
        post_body="test_body",
        category_id=category.category_id + 1,
    )
    url = prefix_url + f"/post"
    res = client.patch(url,
                       json=post,
                       headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url,
                 response=res,
                 post=post,
                 category_id=category.category_id)
    assert res.status_code == 400
    assert "잘못된 접근입니다." == res.json()["msg"]


def test_post_delete(client, login, category, post):
    """
    게시물 삭제
    """
    post_id = 1
    url = prefix_url + f"/post/{post_id}"
    res = client.delete(url,
                        headers=dict(Authorization=login["Authorization"]))
    t_api_logger(url=url, response=res, post_id=post_id)
    assert res.status_code == 200
