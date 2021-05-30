import 'package:blog/const.dart';
import 'package:blog/widget/main_body.dart';
import 'package:flutter/material.dart';

enum ANIMATION_TYPE {
  START,
  CHANGE,
  START_BEACH,
  START_SEA,
  CHAGE_BEACH,
  CHAGE_SEA,
  NONE
}
enum MAIN_PAGE_TYPE { BEACH, SEA }

class MainPage extends StatelessWidget {
  final MAIN_PAGE_TYPE pageType;

  MainPage({required this.pageType});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double sideMenuSize = size.width / 8;
    sideMenuSize = sideMenuSize > 400 ? 400 : sideMenuSize;
    return Scaffold(
      body: Container(
          child: Row(
        children: [
          Container(
            width: sideMenuSize,
            height: size.height,
            color: COLOR_DRAWABLE,
          ),
          MainBody(
            bodySize: Size(size.width - sideMenuSize, size.height),
            pageType: pageType,
          ),
        ],
      )),
    );
  }
}
