import 'package:blog/const.dart';
import 'package:blog/providers/main_widget_notifier.dart';
import 'package:blog/providers/wave_notifier.dart';
import 'package:blog/views/common_components/layout/web_layout.dart';
import 'package:blog/views/main_screen/widget/about_widget.dart';
import 'package:blog/views/main_screen/widget/main_widget.dart';
import 'package:blog/views/page_class_wrapper/page_class.dart';
import 'package:blog/wave_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MAIN_WIDGET { MAIN, ABOUT }

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

  Widget screenWidget(MAIN_WIDGET widget) {
    if (widget == MAIN_WIDGET.ABOUT) return AboutWidget();
    return MainWidget(tempCategory: _tempCategory, tempPost: _tempPost);
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
                          screenWidget(value.mainWidget),
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tooltip(
                message: 'Home',
                child: IconButton(
                  onPressed: () async {
                    context
                        .read<WaveNotifier>()
                        .changeWaveWidth(size.width / 6 * 4);

                    await Future.delayed(Duration(milliseconds: 500));
                    context
                        .read<MainWidgetNotifier>()
                        .changeMainWidget(MAIN_WIDGET.MAIN);
                    context
                        .read<WaveNotifier>()
                        .changeWaveWidth(size.width / 6);
                  },
                  icon: Icon(
                    Icons.home_outlined,
                    color: COLOR_BLACK,
                    size: 32.0,
                  ),
                ),
              ),
              Tooltip(
                message: 'About us',
                child: IconButton(
                  onPressed: () async {
                    context
                        .read<WaveNotifier>()
                        .changeWaveWidth(size.width / 6 * 4);

                    await Future.delayed(Duration(milliseconds: 500));
                    context
                        .read<MainWidgetNotifier>()
                        .changeMainWidget(MAIN_WIDGET.ABOUT);
                    context
                        .read<WaveNotifier>()
                        .changeWaveWidth(size.width / 6);
                  },
                  icon: Icon(
                    Icons.group_outlined,
                    color: COLOR_BLACK,
                    size: 32.0,
                  ),
                ),
              ),
            ],
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
      duration: Duration(milliseconds: 500),
      width: waveWidth,
      curve: Curves.decelerate,
      child: SizedBox(
        child: Stack(
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: WaveAnimation(
                waveSpeed: 2,
                reverse: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
