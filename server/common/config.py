from dataclasses import dataclass
from os import path, environ

base_dir = path.dirname(path.dirname(path.dirname(path.abspath(__file__))))


@dataclass
class Config:
    """
    기본 Configuration
    """
    BASE_DIR = base_dir
    DB_POOL_RECYCLE: int = 900
    DB_ECHO: bool = True
    DEBUG = False
    TEST_MODE: bool = False


@dataclass
class LocalConfig(Config):
    """
    개발 모드
    """
    DB_URL: str = "mysql+pymysql://root:1234@localhost:3306/waveblog?charset=utf8mb4"

    TRUSTED_HOSTS = ["*"]
    ALLOW_SITE = ["*"]
    DEBUG = True


@dataclass
class ProdConfig(Config):
    """
    사용자 모드
    """
    DB_URL: str = "mysql+pymysql://root:1234@localhost:3306/waveblog?charset=utf8mb4"

    TRUSTED_HOSTS = ["*"]
    ALLOW_SITE = ["*"]


@dataclass
class TestConfig(Config):
    """
    사용자 모드
    """
    DB_URL: str = "mysql+pymysql://root:1234@localhost:3306/testwaveblog?charset=utf8mb4"

    TRUSTED_HOSTS = ["*"]
    ALLOW_SITE = ["*"]
    TEST_MODE = True


def conf():
    """
    환경 불러오기
    :return:
    """
    config = dict(prod=ProdConfig, local=LocalConfig, test=TestConfig)
    return config[environ.get("API_ENV", "local")]()