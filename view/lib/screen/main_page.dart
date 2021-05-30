import 'package:blog/const.dart';
import 'package:blog/widget/main_body.dart';
import 'package:flutter/material.dart';

enum ANIMATION_TYPE { START, CHANGE, NONE }
enum MAIN_PAGE_TYPE { BEACH, SEA }

class MainPage extends StatefulWidget {
  MAIN_PAGE_TYPE pageType;

  MainPage({required this.pageType});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
            child: ElevatedButton(
              child: Text('CHANGE!'),
              onPressed: () => setState(() =>
                  (widget.pageType == MAIN_PAGE_TYPE.BEACH)
                      ? widget.pageType = MAIN_PAGE_TYPE.SEA
                      : widget.pageType = MAIN_PAGE_TYPE.BEACH),
            ),
          ),
          MainBody(
            bodySize: Size(size.width - sideMenuSize, size.height),
            pageType: widget.pageType,
          ),
        ],
      )),
    );
  }
}
