import 'package:blog/main.dart';
import 'package:blog/widget/main_body.dart';
import 'package:flutter/material.dart';

abstract class BlogState<T extends StatefulWidget> extends State<T> {
  abstract MainBody body;
  abstract double waveHeight;
  abstract PAGE_TYPE pageType;

  Future<void> startAnim(Size size) async {
    // await Future.delayed(Duration(milliseconds: 500));

    // setState(() {
    //   waveHeight =
    //       pageType == PAGE_TYPE.BEACH ? size.height * 0.38 : size.height * 0.62;
    // });
  }

  Future<void> changeAnim(Size size, PAGE_TYPE changePageType) async {
    // setState(() {
    //   waveHeight = size.height + 100;
    // });

    // await Future.delayed(Duration(milliseconds: 800));
    // pageType = pageType == PAGE_TYPE.SEA ? PAGE_TYPE.BEACH : PAGE_TYPE.SEA;
    // setState(() {
    //   waveHeight =
    //       pageType == PAGE_TYPE.BEACH ? size.height * 0.38 : size.height * 0.62;
    // });
  }
}
