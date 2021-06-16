import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/screen/main_screen.dart';
import 'package:blog/widget/main_background.dart';
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
  late MainBackground bodyBg;

  @override
  late PAGE_TYPE pageType;

  @override
  late double waveHeight;

  @override
  late Duration bgAnimDuration;

  @override
  void initState() {
    super.initState();
    pageType = PAGE_TYPE.BEACH;
    waveHeight = 0;
    bgAnimDuration = Duration(milliseconds: 800);
    // SharedPreference 초기화
    //Comm_Prefs.prefs = await Comm_Prefs.newInstance();
  }

  // 여기 사이즈를 안 받고 화면 중간에 오게 가능할까?
  @override
  Future<void> startAnim({required Size size}) async {
    super.startAnim(size: size);

    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      waveHeight = size.height / 2;
    });
  }

  @override
  @mustCallSuper
  Future<void> changeAnim({
    required Size size,
    required PAGE_TYPE changePageType,
    Widget? changeWidget = null,
  }) async {
    super.changeAnim(size: size, changePageType: changePageType);
    double changeHeight =
        changePageType == PAGE_TYPE.BEACH ? 0 : size.height + 50;

    setState(() {
      waveHeight = changeHeight;
    });
  }

  @override
  void bgAnimationOnEnd(ANIMATION_STATE oldState, PAGE_TYPE changePageType,
      Widget? changeWidget) {
    if (oldState == ANIMATION_STATE.CHANGE_ANIM_RUNNING) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(pageType: changePageType),
          ));
    }
  }

  @override
  Widget buildWidget(BuildContext context, Size size) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            bodyBg,
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if (isAnimStop)
                    changeAnim(size: size, changePageType: PAGE_TYPE.SEA);
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
                  if (currentAnimationState == ANIMATION_STATE.STOP)
                    changeAnim(size: size, changePageType: PAGE_TYPE.BEACH);
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
  void initSetting(BuildContext context, Size size) {
    startAnim(size: size);
  }

  @override
  Widget? buildDrawer(BuildContext context, Size size) => null;
}
