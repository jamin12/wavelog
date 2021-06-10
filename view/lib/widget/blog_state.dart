import 'package:blog/main.dart';
import 'package:blog/widget/main_body.dart';
import 'package:flutter/material.dart';

abstract class BlogState<T extends StatefulWidget> extends State<T> {
  abstract MainBody body;
  abstract double waveHeight;
  abstract PAGE_TYPE pageType;

  bool initSet = false;

  @override
  Widget build(BuildContext context) {
    if (!initSet) {
      initSet = true;
      initSetting(context);
    }
    return buildWidget(context);
  }

  @protected
  void initSetting(BuildContext context);

  @protected
  Widget buildWidget(BuildContext context);

  @protected
  Future<void> startAnim(Size size);

  @protected
  Future<void> changeAnim(Size size, PAGE_TYPE changePageType);
}
