from os import path as op
from sys import path as sp

sp.append(op.dirname(op.dirname(__file__)))

from sqlalchemy import (
    Column,
    Integer,
    String,
    DateTime,
    func,
    ForeignKey,
    TEXT,
)
from sqlalchemy.orm import Session, backref, relationship

from database.conn import Base, db


class BaseMixin:
    created_at = Column(DateTime, nullable=False, default=func.utc_timestamp())
    updated_at = Column(DateTime,
                        nullable=False,
                        default=func.utc_timestamp(),
                        onupdate=func.utc_timestamp())

    def __init__(self):
        self._q = None
        self._session = None
        self.served = None

    def all_columns(self):
        return [
            c for c in self.__table__.columns
            if c.name != "id" and c.name != "created_at"
        ]

    def __hash__(self):
        return hash(self.id)

    @classmethod
    def create(cls, session: Session, auto_commit=False, **kwargs):
        """
        테이블 데이터 적재 전용 함수
        :param session:
        :param auto_commit: 자동 커밋 여부
        :param kwargs: 적재 할 데이터
        :return:
        """
        obj = cls()
        for col in obj.all_columns():
            col_name = col.name
            if col_name in kwargs:
                setattr(obj, col_name, kwargs.get(col_name))
        session.add(obj)
        session.flush()
        if auto_commit:
            session.commit()
        return obj

    @classmethod
    def get(cls, session: Session = None, **kwargs):
        """
        Simply get a Row
        :param session:
        :param kwargs:
        :return:
        """
        sess = next(db.session()) if not session else session
        query = sess.query(cls)
        for key, val in kwargs.items():
            col = getattr(cls, key)
            query = query.filter(col == val)
        if query.count() > 1:
            raise Exception(
                "Only one row is supposed to be returned, but got more than one."
            )
        result = query.first()
        if not session:
            sess.close()
        return result

    @classmethod
    def filter(cls, session: Session = None, **kwargs):
        """
        Simply get a Row
        :param session:
        :param kwargs:
        :return:
        """
        cond = []
        for key, val in kwargs.items():
            key = key.split("__")

            if len(key) > 2:
                raise Exception("No 2 more dunders")
            col = getattr(cls, key[0])
            if len(key) == 1:
                cond.append((col == val))
                #gt : 보다 큰 조건
            elif len(key) == 2 and key[1] == 'gt':
                cond.append((col > val))
                #gte : 보다 크거나 같은 조건
            elif len(key) == 2 and key[1] == 'gte':
                cond.append((col >= val))
                #lt : 보다 작은 조건
            elif len(key) == 2 and key[1] == 'lt':
                cond.append((col < val))
                #lte : 보다 작거나 같은 조건
            elif len(key) == 2 and key[1] == 'lte':
                cond.append((col <= val))
                #in : [1,2,3]등등 조건
            elif len(key) == 2 and key[1] == 'in':
                cond.append((col.in_(val)))
            #예시 user.filter(id__gt = 3)
        obj = cls()
        if session:
            obj._session = session
            obj.served = True
        else:
            obj._session = next(db.session())
            obj.served = False
        query = obj._session.query(cls)
        query = query.filter(*cond)
        obj._q = query
        return obj

    @classmethod
    def cls_attr(cls, col_name=None):
        if col_name:
            col = getattr(cls, col_name)
            return col
        else:
            return cls

    def order_by(self, *args: str):
        for a in args:
            if a.startswith("-"):
                col_name = a[1:]
                is_asc = False
            else:
                col_name = a
                is_asc = True
            col = self.cls_attr(col_name)
            self._q = self._q.order_by(
                col.asc()) if is_asc else self._q.order_by(col.desc())
        return self

    def update(self, auto_commit: bool = False, **kwargs):
        qs = self._q.update(kwargs)
        #이거 용도 뭐징?
        # get_id = self.id
        ret = None

        self._session.flush()
        if qs > 0:
            ret = self._q.first()
        if auto_commit:
            self._session.commit()
        return ret

    def first(self):
        result = self._q.first()
        self.close()
        return result

    def delete(self, auto_commit: bool = False):
        self._q.delete()
        if auto_commit:
            self._session.commit()

    def all(self):
        result = self._q.all()
        self.close()
        return result

    def count(self):
        result = self._q.count()
        self.close()
        return result

    def close(self):
        if not self.served:
            self._session.close()
        else:
            self._session.flush()


class Users(Base, BaseMixin):
    # 유저 테이블
    __tablename__ = "Users"
    user_id = Column(Integer, primary_key=True, index=True)
    user_name = Column(String(40), nullable=False, unique=True)
    password = Column(String(255), nullable=False)
    email = Column(String(255), nullable=True)
    phone_num = Column(String(50), nullable=True)
    residence = Column(String(255), nullable=True)

    #관계 형성
    user_category = relationship(
        "Categories",
        backref=backref("users"),
        cascade="all, delete-orphan, save-update",
        passive_deletes=True,
    )
    user_post = relationship(
        "Posts",
        backref=backref("user"),
        cascade="all, delete-orphan, save-update",
        passive_deletes=True,
    )


class Categories(Base, BaseMixin):
    __tablename__ = "Categories"
    #카테고리 테이블
    category_id = Column(Integer, primary_key=True, index=True)
    category_name = Column(String(200), nullable=False)
    category_color = Column(String(45), nullable=True, default="red")
    user_id = Column(
        Integer,
        ForeignKey("Users.user_id", ondelete="CASCADE", onupdate="CASCADE"),
        nullable=False,
    )

    #관계 형성
    posts = relationship(
        "Posts",
        backref=backref("categories"),
        cascade="all, delete-orphan, save-update",
        passive_deletes=True,
    )


class Posts(Base, BaseMixin):
    #게시물 테이블
    __tablename__ = "Posts"
    post_id = Column(Integer, primary_key=True, index=True)
    post_title = Column(String(255), nullable=True)
    category_id = Column(
        Integer,
        ForeignKey("Categories.category_id",
                   ondelete="CASCADE",
                   onupdate="CASCADE"),
        nullable=False,
    )
    user_id = Column(
        Integer,
        ForeignKey("Users.user_id", ondelete="CASCADE", onupdate="CASCADE"),
        nullable=False,
    )

    #관계 형성
    comment = relationship(
        "Comment",
        backref=backref("Posts"),
        cascade="all,delete-orphan",
        passive_deletes=True,
    )


class PostBody(Base, BaseMixin):
    #게시물 본문 테이블
    __tablename__ = "PostBody"
    id = None
    post_id = Column(
        Integer,
        ForeignKey("Posts.post_id", ondelete="CASCADE", onupdate="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    post_body = Column(TEXT, nullable=True)

    #관계 형성
    post = relationship("Posts", backref=backref("post_body", uselist=False))


class Comment(Base, BaseMixin):
    __tablename__ = "Comment"
    comment_id = Column(Integer, primary_key=True, nullable=False, index=True)
    post_id = Column(Integer, ForeignKey("Posts.post_id", ondelete="CASCADE"))
    nick_name = Column(String(255), nullable=False)
    password = Column(String(255), nullable=False)
    comment_body = Column(String(255), nullable=False)
