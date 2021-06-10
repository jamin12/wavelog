import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/screen/main_screen.dart';
import 'package:blog/widget/main_body.dart';
import 'package:blog/widget/blog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BlogState {
  @override
  late MainBody body;

  @override
  late PAGE_TYPE pageType;

  @override
  late double waveHeight;

  bool isChangeAnimRun = false;

  @override
  void initState() {
    super.initState();
    pageType = PAGE_TYPE.BEACH;
    waveHeight = 0;
  }

  // 여기 사이즈를 안 받고 화면 중간에 오게 가능할까?
  @override
  Future<void> startAnim(Size size) async {
    if (!isChangeAnimRun) {
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        waveHeight = size.height / 2;
      });
    }
  }

  @override
  Future<void> changeAnim(Size size, PAGE_TYPE changePageType) async {
    isChangeAnimRun = true;
    double changeHeight =
        changePageType == PAGE_TYPE.BEACH ? 0 : size.height + 50;

    setState(() {
      waveHeight = changeHeight;
    });

    await Future.delayed(Duration(milliseconds: 800));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(pageType: changePageType),
        ));
  }

  @override
  Widget buildWidget(BuildContext context, Size size) {
    if (waveHeight == 0) startAnim(size);
    body = MainBody(
      waveHeight: waveHeight,
      pageType: pageType,
      animationDuration: Duration(milliseconds: 800),
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            body,
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  changeAnim(size, PAGE_TYPE.SEA);
                },
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: COLOR_DRAWABLE,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/fish.svg',
                        color: COLOR_BEACH,
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        SEA_USER_NAME,
                        style: TextStyle(color: COLOR_BEACH, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  changeAnim(size, PAGE_TYPE.BEACH);
                },
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: COLOR_DRAWABLE,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/umbrella.svg',
                        color: COLOR_BEACH,
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        BEACH_USER_NAME,
                        style: TextStyle(color: COLOR_BEACH, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initSetting(BuildContext context, Size size) {}
}
