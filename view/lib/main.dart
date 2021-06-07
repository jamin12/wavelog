import 'package:blog/const.dart';
import 'package:blog/screen/main_page.dart';
import 'package:blog/screen/splash_page.dart';
import 'package:blog/widget/wave_animation.dart';
import 'package:flutter/material.dart';

enum ANIMATION_TYPE { START, CHANGE, NONE }
enum PAGE_TYPE { BEACH, SEA }

void main() => runApp(Blog());

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (BodyWidget.of(context) != null)
    //   BodyWidget.of(context)!.initAnimation(animType: ANIMATION_TYPE.START);

    return MaterialApp(
        title: 'Wavelog',
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        // home: SplashPage(),
        home: Main());
  }
}

// 이게 기본이 되어야 함 흠 ㅈ나 어렵네
class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late MainBody body;
  late double waveHeight;
  late PAGE_TYPE pageType;
  @override
  void initState() {
    super.initState();
    waveHeight = 0;
    pageType = PAGE_TYPE.SEA;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    body = MainBody(
      waveHeight,
      pageType: pageType,
    );
    if (waveHeight == 0) startAnim(size);

    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        child: Text('버튼'),
        onPressed: () {
          onTap(size);
        },
      ),
    );
  }

  Future<void> startAnim(Size size) async {
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      waveHeight =
          pageType == PAGE_TYPE.BEACH ? size.height * 0.38 : size.height * 0.62;
    });
  }

  Future<void> onTap(Size size) async {
    setState(() {
      waveHeight = size.height + 100;
    });

    await Future.delayed(Duration(milliseconds: 800));
    pageType = pageType == PAGE_TYPE.SEA ? PAGE_TYPE.BEACH : PAGE_TYPE.SEA;
    setState(() {
      waveHeight =
          pageType == PAGE_TYPE.BEACH ? size.height * 0.38 : size.height * 0.62;
    });
  }
}

class MainBody extends StatelessWidget {
  final double waveHeight;
  final PAGE_TYPE pageType;

  MainBody(this.waveHeight, {Key? key, required this.pageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: COLOR_BEACH,
      child: Stack(
        children: List.generate(3, (index) {
          Color waveColor = index == 0
              ? COLOR_SEA.withBlue(255).withOpacity(0.4)
              : index == 1
                  ? COLOR_SEA.withBlue(200).withOpacity(0.4)
                  : COLOR_SEA.withOpacity(0.4);

          return Positioned(
            top: pageType == PAGE_TYPE.BEACH ? 0 : null,
            bottom: pageType == PAGE_TYPE.BEACH ? null : 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              curve: Curves.decelerate,
              duration: Duration(milliseconds: 500),
              height: waveHeight,
              child: RotatedBox(
                quarterTurns: pageType == PAGE_TYPE.BEACH ? 2 : 0,
                child: WaveAnimation(
                  waveColor: waveColor,
                  waveSpeed: 3 + index,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
