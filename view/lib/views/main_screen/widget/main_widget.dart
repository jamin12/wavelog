import 'package:blog/const.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late int speedFactor;

  @override
  void initState() {
    _scrollController = ScrollController();
    speedFactor = 50;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _autoScroll();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _autoScroll() {
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double distanceDifferent = maxScrollExtent - _scrollController.offset;
    double durationDouble = distanceDifferent / speedFactor;
    _scrollController.animateTo(maxScrollExtent,
        duration: Duration(seconds: durationDouble.toInt()),
        curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      controller: _scrollController,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),
            Text(
              'Wavelog',
              style: TextStyle(
                fontSize: 80.0,
                color: COLOR_BLACK,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Developers',
              style: TextStyle(
                  fontSize: 40.0,
                  color: COLOR_BLACK,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.0),
            Text(
              '(Font-End)Kwon Tae Woong',
              style: TextStyle(
                  fontSize: 20.0,
                  color: COLOR_BLACK,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발',
              style: TextStyle(
                  fontSize: 20.0,
                  color: COLOR_BLACK,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 10.0),
            Text(
              '(Back-End)Kang Kyung Min',
              style: TextStyle(
                  fontSize: 20.0,
                  color: COLOR_BLACK,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 ',
              style: TextStyle(
                  fontSize: 20.0,
                  color: COLOR_BLACK,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
