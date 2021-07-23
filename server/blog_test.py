import requests
from datetime import datetime, timedelta


def parse_params_to_str(params):
    url = "?"
    for key, value in params.items():
        url = url + str(key) + '=' + str(value) + '&'
    return url[1:-1]


def sample_request():
    cur_time = datetime.utcnow() + timedelta(hours=9)
    cur_timestamp = int(cur_time.timestamp())
    qs = dict(timestamp=cur_timestamp)

    url = f"http://127.0.0.1:8080/blog/service/contents/1/1?{parse_params_to_str(qs)}"
    res = requests.get(url)
    return res


print(sample_request().json())