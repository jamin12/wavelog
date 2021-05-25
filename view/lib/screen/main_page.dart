import 'package:blog/const.dart';
import 'package:blog/screen/detail_main_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

// 파도, 해변, 바다, 없음
enum ANIMATION_TYPE { WAVE, BEACH, SEA, NONE }

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  // 기본 파도 Animation Controller
  late AnimationController _waveController;
  // 해변 이동 Animation Controller
  late AnimationController _beachChangeController;
  // 바다 이동 Animation Controller
  late AnimationController _seaChangeController;
  // 기본 파도 Animation
  late Animation<double> _animation;
  // 해변 이동 Animation
  late Animation<double> _beachChangeAnimation;
  // 바다 이동 Animation
  late Animation<double> _seaChangeAnimation;
  // 에니메이션 타입
  late ANIMATION_TYPE _animationType;

  @override
  void initState() {
    super.initState();

    // 애니메이션 타입 초기화
    _animationType = ANIMATION_TYPE.WAVE;
    // 애니메이션 초기화
    _waveController = AnimationController(
        vsync: this, duration: Duration(seconds: 2), value: 0);
    _animation = Tween<double>(begin: -100, end: 0).animate(_waveController)
      ..addListener(() {
        setState(() {});
      });

    _beachChangeController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 0);
    _seaChangeController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 0);

    _waveController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _beachChangeController.dispose();
    _seaChangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int waveCount = 30;
    _seaChangeAnimation =
        Tween<double>(begin: _animation.value, end: size.height / 2)
            .animate(_seaChangeController)
              ..addListener(() {
                if (_seaChangeController.isAnimating)
                  setState(() {});
                else if (_seaChangeController.isCompleted &&
                    _animationType != ANIMATION_TYPE.NONE) {
                  _animationType = ANIMATION_TYPE.NONE;
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => DetailMainPage(
                            pageType: DETAIL_PAGE_TYPE.BEACH,
                          )));
                }
              });
    _beachChangeAnimation =
        Tween<double>(begin: _animation.value, end: -size.height / 7 * 5)
            .animate(_beachChangeController)
              ..addListener(() {
                if (_beachChangeController.isAnimating)
                  setState(() {});
                else if (_beachChangeController.isCompleted &&
                    _animationType != ANIMATION_TYPE.NONE) {
                  _animationType = ANIMATION_TYPE.NONE;
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) =>
                          DetailMainPage(pageType: DETAIL_PAGE_TYPE.SEA)));
                }
              });

    final double waveSize = size.width / (waveCount);

    return Scaffold(
      body: Container(
        color: COLOR_BEACH,
        child: Stack(
          children: [
            _buildWave(waveCount, size, waveSize),
            Positioned(
              top: size.height / 10,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _animationType = ANIMATION_TYPE.SEA;

                    if (_waveController.isAnimating) _waveController.stop();
                    _seaChangeController.forward();
                  });
                },
                child: CircleAvatar(
                  backgroundColor: COLOR_BEACH,
                  radius: 100,
                ),
              ),
            ),
            Positioned(
              bottom: size.height / 10,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _animationType = ANIMATION_TYPE.BEACH;
                    if (_waveController.isAnimating) _waveController.stop();
                    _beachChangeController.forward();
                  });
                },
                child: CircleAvatar(
                  backgroundColor: COLOR_SEA,
                  radius: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 일렁이는 파도 및 이동 애니메이션 빌드
  Stack _buildWave(int waveCount, Size size, double waveSize) {
    final double waveHeight = size.height / 7 * 4;
    final double waveWidth = waveSize * 1.5;
    return Stack(
      alignment: Alignment.center,
      children: List.generate(
        waveCount,
        (index) {
          double wavePosition = 0;

          switch (_animationType) {
            case ANIMATION_TYPE.WAVE: // 물결
              wavePosition = _animation.value;
              break;
            case ANIMATION_TYPE.SEA: // 바다
              wavePosition = _seaChangeAnimation.value;
              break;
            case ANIMATION_TYPE.BEACH: // 해변
              wavePosition = _beachChangeAnimation.value;
              break;
            default: // 올 일 없음
              wavePosition = 0;
          }

          if (index == 0) // 처음 바다 부분
            return Positioned(
              top: wavePosition - waveHeight,
              left: 0,
              right: 0,
              child: Container(
                height: waveHeight * 2,
                color: COLOR_SEA,
              ),
            );

          final int realIndex = index - 1;

          if (index % 2 == 0) {
            return Positioned(
              top: wavePosition + waveHeight - waveSize / 2 - 3,
              left: realIndex * waveWidth,
              child: ClipOval(
                child: Container(
                  width: waveWidth,
                  height: waveSize,
                  color: COLOR_SEA,
                ),
              ),
            );
          } else {
            return Positioned(
              top: wavePosition + waveHeight - waveSize / 2 + 3,
              left: realIndex * waveWidth,
              child: ClipOval(
                child: Container(
                  width: waveWidth,
                  height: waveSize,
                  color: COLOR_BEACH,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
