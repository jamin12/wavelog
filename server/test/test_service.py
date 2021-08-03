from database.schema import Users, Categories, Posts, Comment, PostBody
from utils.logger import t_api_logger
from model import UserToken, contents
import bcrypt

url_prefix = "/blog/service"
"""
TODO 왜 한번에 하면 안되고 따로따로 하면 되는 것인가......
"""


def test_about(client, login):
    """
    about page
    """
    user_name = "test"
    user = Users.get(user_name=user_name)
    url = url_prefix + f"/about/{user_name}"
    res = client.get(url)
    t_api_logger(response=res, url=url)
    assert res.status_code == 200
    assert res.json() == UserToken.from_orm(user)


def test_about_none_user(client):
    """
    about page none user
    """
    user_name = "test1"
    url = url_prefix + f"/about/{user_name}"
    res = client.get(url)
    t_api_logger(response=res, url=url)
    assert res.status_code == 404
    assert res.json()["msg"] == "page not found"


def test_contents(client, login, category, post):
    """
    컨텐츠 페이지
    """
    category = Categories.get(category_id=1)
    post = Posts.get(post_id=1)
    post_orm = contents.from_orm(post)
    category_orm = contents.from_orm(category)
    user_id = 1
    category_id = 1
    url = url_prefix + f"/contents/{user_id}/{category_id}"
    res = client.get(url)
    t_api_logger(response=res,
                 url=url,
                 post_orm=post_orm.dict(exclude_unset=True),
                 category_orm=category_orm.dict(exclude_unset=True))
    assert res.status_code == 200
    assert res.json() == [
        post_orm.dict(exclude_unset=True),
        category_orm.dict(exclude_unset=True)
    ]


def test_contesnts_check_category(client, login, category):
    """
    컨텐츠 페이지, 카테고리 없을 경우
    """
    user_id = 1
    category_id = 2
    url = url_prefix + f"/contents/{user_id}/{category_id}"
    res = client.get(url)
    t_api_logger(response=res, url=url)
    assert res.status_code == 404


def test_get_post(client, login, category, post, comment):
    """
    게시물 페이지
    """
    comment_body = []
    comments = Comment.filter(post_id=1).all()
    post_body = PostBody.get(post_id=1)
    for comment in comments:
        comment_body.append(comment.comment_body)
    post = Posts.get(post_id=1)
    user_id = 1
    post_id = 1
    url = url_prefix + f"/getpost/{user_id}/{post_id}"
    res = client.get(url)
    t_api_logger(response=res, url=url)
    assert res.status_code == 200
    assert res.json() == {
        "post_title": post.post_title,
        "post_body": post_body.post_body,
        "comment": comment_body
    }


def test_get_post_none_post(client, login, category, post, comment):
    """
    게시물 페이지,페이지가 없을 때
    """

    user_id = 1
    post_id = 2
    url = url_prefix + f"/getpost/{user_id}/{post_id}"
    res = client.get(url)
    t_api_logger(response=res, url=url)
    assert res.status_code == 404


def test_comment_register(client, login, category, post):
    """
    댓글 생성
    """
    comment_info = dict(post_id=1,
                        nick_name="test_name",
                        comment_body="test_comment",
                        password="1234")
    url = url_prefix + "/comment"
    res = client.post(url, json=comment_info)
    t_api_logger(response=res, url=url)
    assert res.status_code == 201


def test_comment_delete(client, login, category, post, comment):
    """
    댓글 삭제
    """
    comment_id = 1
    password = "qwer1234"
    url = url_prefix + f"/comment/{comment_id}/{password}"
    res = client.delete(url)
    t_api_logger(response=res, url=url)
    assert res.status_code == 200


def test_comment_delete_check_password(client, login, category, post, comment):
    """
    댓글 삭제,비밀번호 틀렸을 때
    """
    comment_id = 1
    password = "qwer12341"
    url = url_prefix + f"/comment/{comment_id}/{password}"
    res = client.delete(url)
    t_api_logger(response=res, url=url)
    assert res.status_code == 400


def test_comment_update(client, login, category, post, comment):
    """
    댓글 수정
    """
    comment_id = 1
    password = "qwer1234"
    change_comment = "test_change_comment"
    url = url_prefix + f"/comment/{comment_id}/{password}/{change_comment}"
    res = client.patch(url)
    t_api_logger(response=res, url=url)
    assert res.status_code == 200