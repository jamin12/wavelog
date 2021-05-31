import 'package:blog/const.dart';
import 'package:blog/widget/main_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ANIMATION_TYPE { START, CHANGE, NONE }
enum MAIN_PAGE_TYPE { BEACH, SEA }

class MainPage extends StatefulWidget {
  final MAIN_PAGE_TYPE pageType;

  MainPage({required this.pageType});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MAIN_PAGE_TYPE _currentPageType;
  late MainBody _mainPage;
  @override
  void initState() {
    super.initState();
    _currentPageType = widget.pageType;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double sideMenuSize = size.width / 8;
    sideMenuSize = sideMenuSize > 400 ? 400 : sideMenuSize;

    _mainPage = MainBody(
      bodySize: Size(size.width - sideMenuSize, size.height),
      pageType: widget.pageType,
    );

    return Scaffold(
      body: Container(
          child: Row(
        children: [
          Container(
            width: sideMenuSize,
            height: size.height,
            color: COLOR_DRAWABLE,
            child: Column(
              children: [
                DrawerHeader(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        radius: size.width >= 500 ? 30 : 20,
                        backgroundColor: COLOR_BEACH,
                        child: SvgPicture.asset(
                          _currentPageType == MAIN_PAGE_TYPE.BEACH
                              ? 'assets/umbrella.svg'
                              : 'assets/fish.svg',
                          width: size.width >= 500 ? 30 : 20,
                          height: size.width >= 500 ? 30 : 20,
                          color: COLOR_DRAWABLE,
                        ),
                      ),
                      Visibility(
                        visible: size.width >= 1600,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            _currentPageType == MAIN_PAGE_TYPE.BEACH
                                ? BEACH_USER_NAME
                                : SEA_USER_NAME,
                            style: TextStyle(fontSize: 15, color: COLOR_BEACH),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: COLOR_BEACH,
                  height: 1,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Material(
                  color: COLOR_DRAWABLE,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        bodyChange();
                      });
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: COLOR_BEACH,
                            child: SvgPicture.asset(
                              _currentPageType != MAIN_PAGE_TYPE.BEACH
                                  ? 'assets/umbrella.svg'
                                  : 'assets/fish.svg',
                              width: 20,
                              height: 20,
                              color: COLOR_DRAWABLE,
                            ),
                          ),
                          Visibility(
                            visible: size.width >= 1600,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                _currentPageType != MAIN_PAGE_TYPE.BEACH
                                    ? BEACH_USER_NAME
                                    : SEA_USER_NAME,
                                style:
                                    TextStyle(fontSize: 12, color: COLOR_BEACH),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _mainPage
        ],
      )),
    );
  }

  void bodyChange() {
    (_currentPageType == MAIN_PAGE_TYPE.BEACH)
        ? _currentPageType = MAIN_PAGE_TYPE.SEA
        : _currentPageType = MAIN_PAGE_TYPE.BEACH;

    _mainPage.changePage(_currentPageType);
  }
}
