import 'package:blog/const.dart';
import 'package:blog/providers/main_widget_notifier.dart';
import 'package:blog/providers/wave_notifier.dart';
import 'package:blog/views/common_components/layout/web_layout.dart';
import 'package:blog/views/main_screen/widget/about_widget.dart';
import 'package:blog/views/main_screen/widget/contents_widget.dart';
import 'package:blog/views/page_class_wrapper/page_class.dart';
import 'package:blog/wave_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  Widget appScaffold(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  /// 메인 스크린 위젯 설정
  Widget screenWidget(BuildContext context, Size size, MAIN_WIDGET widget) {
    switch (widget) {
      case MAIN_WIDGET.MAIN:
        return MainWidget();
      case MAIN_WIDGET.ABOUT:
        return AboutWidget();
      case MAIN_WIDGET.DETAIL:
        return DetailWidget();
      case MAIN_WIDGET.CONTENTS:
        return ContentsWidget(
          tempCategory: _tempCategory,
          tempPost: _tempPost,
          itemClickListener: (int index) {
            changeView(context, size, changeView: MAIN_WIDGET.DETAIL);
          },
        );
      default:
        return MainWidget();
    }
  }

  void changeView(BuildContext context, Size size,
      {required MAIN_WIDGET changeView}) async {
    context.read<WaveNotifier>().changeWaveWidth(size.width / 3 * 2);

    await Future.delayed(Duration(milliseconds: 800));
    context.read<MainWidgetNotifier>().changeMainWidget(changeView);

    await Future.delayed(Duration(milliseconds: 100));
    context.read<WaveNotifier>().changeWaveWidth(size.width / 6);
  }

  @override
  Widget webScaffold(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // context.read<WaveNotifier>().changeWaveWidth(size.width / 6);
    return Scaffold(
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: Consumer<MainWidgetNotifier>(
                      builder: (context, value, child) =>
                          screenWidget(context, size, value.mainWidget),
                    ),
                  ),
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
                        changeView(context, size, changeView: MAIN_WIDGET.MAIN);
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

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50.0,
        ),
        SelectableText(
          'Title',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: COLOR_BLACK,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        SelectableText(
          '내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20.0,
            color: COLOR_BLACK,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            children: [
              Container(
                width: 200.0,
                margin: const EdgeInsets.only(right: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelText: 'Nickname',
                  ),
                ),
              ),
              Container(
                width: 250.0,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelText: 'Password',
                  ),
                ),
              ),
            ],
          ),
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLength: null,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              bottom: 16.0,
              top: 8.0,
              left: 10.0,
              right: 10.0,
            ),
            // isCollapsed: true,
            alignLabelWithHint: true,
            suffixIcon: Icon(Icons.send),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: COLOR_BACK)),
            labelText: 'Contents',
          ),
        ),
      ],
    );
  }
}

class BuildWave extends StatefulWidget {
  final double initWaveSize;

  const BuildWave(
    this.initWaveSize, {
    Key? key,
  }) : super(key: key);

  @override
  _BuildWaveState createState() => _BuildWaveState();
}

class _BuildWaveState extends State<BuildWave> {
  late double waveWidth;
  @override
  void initState() {
    super.initState();
    waveWidth = widget.initWaveSize;
  }

  @override
  Widget build(BuildContext context) {
    waveWidth = (context.watch<WaveNotifier>().waveWidth > 0)
        ? context.watch<WaveNotifier>().waveWidth
        : waveWidth;

    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      width: waveWidth,
      curve: Curves.decelerate,
      child: RotatedBox(
        quarterTurns: 1,
        child: WaveAnimation(
          waveSpeed: 2,
          reverse: false,
        ),
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50.0),
          Text(
            'Wavelog',
            style: TextStyle(
                fontSize: 80.0,
                color: COLOR_BLACK,
                fontWeight: FontWeight.bold),
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
            'Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발 Font-End 개발',
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
            'Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 Back-End 개발 ',
            style: TextStyle(
                fontSize: 20.0,
                color: COLOR_BLACK,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
