import 'package:blog/const.dart';
import 'package:blog/providers/main_widget_notifier.dart';
import 'package:blog/providers/wave_notifier.dart';
import 'package:blog/utils/http_utils.dart';
import 'package:blog/views/common_components/layout/web_layout.dart';
import 'package:blog/views/main_screen/widget/about_widget.dart';
import 'package:blog/views/main_screen/widget/contents_widget.dart';
import 'package:blog/views/main_screen/widget/detail_widget.dart';
import 'package:blog/views/main_screen/widget/edit_category_widget.dart';
import 'package:blog/views/main_screen/widget/edit_post_widget.dart';
import 'package:blog/views/main_screen/widget/main_widget.dart';
import 'package:blog/views/main_screen/widget/wave_widget.dart';
import 'package:blog/views/page_class_wrapper/page_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum MAIN_WIDGET { MAIN, CONTENTS, ABOUT, DETAIL }

// ignore: must_be_immutable
class MainScreen extends PageClass {
  final List<String> _tempCategory = [
    'All',
    'Category 1',
    'Category 2',
    'Category 3'
  ];

  final List<String> _tempPost = [
    'All',
    'Post 1',
    'Post 2',
    'Post 3',
    'Post 4',
    'Post 5',
    'Post 6',
    'Post 7',
    'Post 8',
    'Post 9',
    '이게 뭔가 가치있는 제목인것 같아 보이게 한다 ㅋㅋ 근데 아마 의도대로는 되지 않을것이다.',
  ];
  late double _waveWidth;

  @override
  void initSetting(BuildContext context) {
    _waveWidth = context.read<WaveNotifier>().waveWidth;
    BlogHttp.get('', (code, body) => print(body));
  }

  @override
  Widget appScaffold(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        body: Container(),
      ),
    );
  }

  /// 메인 스크린 위젯 설정
  Widget screenWidget(BuildContext context, Size size, MAIN_WIDGET widget) {
    late Widget screenWidget;

    switch (widget) {
      case MAIN_WIDGET.MAIN:
        return MainWidget();
      case MAIN_WIDGET.ABOUT:
        screenWidget = AboutWidget();
        break;
      case MAIN_WIDGET.DETAIL:
        screenWidget = DetailWidget();
        break;
      case MAIN_WIDGET.CONTENTS:
        screenWidget = ContentsWidget(
          tempCategory: _tempCategory,
          tempPost: _tempPost,
          itemClickListener: (int index) {
            changeView(context, size, changeView: MAIN_WIDGET.DETAIL);
          },
        );
        break;
      default:
        return MainWidget();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0), child: screenWidget),
    );
  }

  void changeView(BuildContext context, Size size,
      {required MAIN_WIDGET changeView}) async {
    context.read<WaveNotifier>().changeWaveWidth(size.width / 3 * 2);

    await Future.delayed(Duration(milliseconds: 500));
    context.read<MainWidgetNotifier>().changeMainWidget(changeView);

    await Future.delayed(Duration(milliseconds: 50));
    context.read<WaveNotifier>().changeWaveWidth(size.width / 6);
  }

  @override
  Widget webScaffold(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // context.read<WaveNotifier>().changeWaveWidth(size.width / 6);
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        body: WebLayout(
          mainContents: (context) => Container(
            color: COLOR_BEACH,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: size.width / 6 * 3,
                  child: Consumer<MainWidgetNotifier>(
                    builder: (context, value, child) =>
                        screenWidget(context, size, value.mainWidget),
                  ),
                ),
                _buildWave(context),
                _buildSide(size),
              ],
            ),
          ),
          menu: (context) => Container(
            color: COLOR_BEACH,
            child: Consumer<MainWidgetNotifier>(
              builder: (_, MainWidgetNotifier value, __) => Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tooltip(
                    message: 'Home',
                    child: IconButton(
                      onPressed: () async {
                        if (value.mainWidget != MAIN_WIDGET.MAIN) {
                          changeView(context, size,
                              changeView: MAIN_WIDGET.MAIN);
                        }
                      },
                      icon: Icon(
                        Icons.home,
                        color: value.mainWidget == MAIN_WIDGET.MAIN
                            ? COLOR_BACK
                            : COLOR_BLACK,
                        size: 32.0,
                      ),
                    ),
                  ),
                  Tooltip(
                    message: 'Contents',
                    child: IconButton(
                      onPressed: () async {
                        if (value.mainWidget != MAIN_WIDGET.CONTENTS) {
                          changeView(context, size,
                              changeView: MAIN_WIDGET.CONTENTS);
                        }
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: value.mainWidget == MAIN_WIDGET.CONTENTS
                            ? COLOR_BACK
                            : COLOR_BLACK,
                        size: 32.0,
                      ),
                    ),
                  ),
                  Tooltip(
                    message: 'About us',
                    child: IconButton(
                      onPressed: () async {
                        if (value.mainWidget != MAIN_WIDGET.ABOUT) {
                          changeView(context, size,
                              changeView: MAIN_WIDGET.ABOUT);
                        }
                      },
                      icon: Icon(
                        Icons.group,
                        color: value.mainWidget == MAIN_WIDGET.ABOUT
                            ? COLOR_BACK
                            : COLOR_BLACK,
                        size: 32.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWave(BuildContext context) {
    return BuildWave(MediaQuery.of(context).size.width / 6);
  }

  Positioned _buildSide(Size size) {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      width: size.width / 6,
      child: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: size.width / 12,
                height: size.width / 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: COLOR_BEACH,
                  border: Border.all(
                      color: COLOR_BACK, style: BorderStyle.solid, width: 10.0),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5.0, 5.0),
                      color: COLOR_BEACH,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(),
              ),
            ),
            Expanded(
              child: Center(),
            ),
          ],
        ),
      ),
    );
  }
}
