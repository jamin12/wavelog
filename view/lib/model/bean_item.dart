import 'package:flutter/material.dart';

class BeanItem {
  // 키값
  final String id;
  // 제목
  final String title;
  // 아이템 색상
  final Color color;
  // 작성자
  final String writer;
  // 읽은 수
  final int views;
  // 내용
  final String contents;

  BeanItem(this.id,
      [this.title = '',
      this.color = Colors.red,
      this.writer = '',
      this.views = 0,
      this.contents = '']);
}
