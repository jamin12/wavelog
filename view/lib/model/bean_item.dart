import 'package:flutter/material.dart';

class BeanItem {
  // 키값
  String id;
  // 제목
  String title;
  // 아이템 색상
  Color color;
  // 작성자
  String writer;
  // 읽은 수
  int views;
  // 내용
  String contents;
  // 작성날짜
  String writeDate;
  BeanItem(
      {this.id = '',
      this.title = '',
      this.color = Colors.red,
      this.writer = '',
      this.views = 0,
      this.contents = '',
      this.writeDate = '',
      String? value}) {
    if (value != null) {
      List<String> items = value.split(tag);
      this.id = items.first;
      this.title = items[1];
      this.color = Color(int.parse(items[2]));
      this.writer = items[3];
      this.views = int.parse(items[4]);
      this.contents = items[5];
      this.writeDate = items.last;
    }
  }

  static String tag = '<kmeoung>';

  String get string {
    String toString = '';
    toString =
        '$id$tag$title$tag${color.value}$tag$writer$tag$views$tag$contents$tag$writeDate';
    return toString;
  }
}
