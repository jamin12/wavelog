from utils.logger import t_api_logger
from database.schema import Users


def test_category_register(client, login):
    user = Users.get(user_name="test")
    category = dict(user_id=user.user_id, category_name="test_category")
    res = client.post("/blog/useract/category",
                      json=category,
                      headers=dict(Authorization=login["Authorization"]))
    res_body = res.json()
    t_api_logger(res_body)
    assert res.status_code == 201