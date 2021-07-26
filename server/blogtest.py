import json
import logging
from fastapi.logger import logger
import requests
import json
from datetime import datetime, timedelta

logger.setLevel(logging.INFO)
logging.basicConfig(level=logging.INFO)


def parse_params_to_str(params):
    url = "?"
    for key, value in params.items():
        url = url + str(key) + '=' + str(value) + '&'
    return url[1:-1]


def sample_request():
    cur_time = datetime.utcnow() + timedelta(hours=9)
    cur_timestamp = int(cur_time.timestamp())
    qs = dict(timestamp=cur_timestamp)
    url = f"http://127.0.0.1:8080/blog/service?{parse_params_to_str(qs)}"
    res = requests.get(url, )
    return res


a = dict(msg="test")
logger.info(json.dumps(a))
print(sample_request().json())
