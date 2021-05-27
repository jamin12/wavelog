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
  // 에니메이션 타입
  late ANIMATION_TYPE _animationType;

  // 애니메이션 컨트롤러
  late Map<ANIMATION_TYPE, AnimationController> _controllers;
  // 애니메이션
  late Map<ANIMATION_TYPE, Animation<double>?> _animations;

  @override
  void initState() {
    super.initState();

    // 애니메이션 타입 초기화
    _animationType = ANIMATION_TYPE.WAVE;

    // 애니메이션 컨트롤러 초기화
    _controllers = {
      ANIMATION_TYPE.WAVE: AnimationController(
          vsync: this, duration: Duration(seconds: 2), value: 0),
      ANIMATION_TYPE.BEACH: AnimationController(
          vsync: this, duration: Duration(milliseconds: 500), value: 0),
      ANIMATION_TYPE.SEA: AnimationController(
          vsync: this, duration: Duration(milliseconds: 500), value: 0),
    };

    // 애니메이션 초기화
    _animations = {
      ANIMATION_TYPE.WAVE: Tween<double>(begin: -100, end: 0)
          .animate(_controllers[ANIMATION_TYPE.WAVE]!)
            ..addListener(() {
              setState(() {});
            }),
      ANIMATION_TYPE.BEACH: null,
      ANIMATION_TYPE.SEA: null,
    };

    _controllers[ANIMATION_TYPE.BEACH] = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 0);
    _controllers[ANIMATION_TYPE.SEA] = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 0);

    _controllers[ANIMATION_TYPE.WAVE]!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int waveCount = 30;
    _animations[ANIMATION_TYPE.SEA] = Tween<double>(
            begin: _animations[ANIMATION_TYPE.WAVE]!.value,
            end: size.height / 2)
        .animate(_controllers[ANIMATION_TYPE.SEA]!)
          ..addListener(() {
            if (_controllers[ANIMATION_TYPE.SEA]!.isAnimating)
              setState(() {});
            else if (_controllers[ANIMATION_TYPE.SEA]!.isCompleted &&
                _animationType != ANIMATION_TYPE.NONE) {
              _animationType = ANIMATION_TYPE.NONE;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => DetailMainPage(
                        pageType: DETAIL_PAGE_TYPE.BEACH,
                      )));
            }
          });
    _animations[ANIMATION_TYPE.BEACH] = Tween<double>(
            begin: _animations[ANIMATION_TYPE.WAVE]!.value,
            end: -size.height / 7 * 5)
        .animate(_controllers[ANIMATION_TYPE.BEACH]!)
          ..addListener(() {
            if (_controllers[ANIMATION_TYPE.BEACH]!.isAnimating)
              setState(() {});
            else if (_controllers[ANIMATION_TYPE.BEACH]!.isCompleted &&
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

                    if (_controllers[ANIMATION_TYPE.WAVE]!.isAnimating)
                      _controllers[ANIMATION_TYPE.WAVE]!.stop();
                    _controllers[ANIMATION_TYPE.SEA]!.forward();
                  });
                },
                child: CircleAvatar(
                  backgroundColor: COLOR_BEACH,
                  radius: 100,
                  child: Center(
                    child: Text(
                      'Kang Kyung Min',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
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
                    if (_controllers[ANIMATION_TYPE.WAVE]!.isAnimating)
                      _controllers[ANIMATION_TYPE.WAVE]!.stop();
                    _controllers[ANIMATION_TYPE.BEACH]!.forward();
                  });
                },
                child: CircleAvatar(
                  backgroundColor: COLOR_SEA,
                  radius: 100,
                  child: Center(
                    child: Text('Kwon Tae Woong',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
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
              wavePosition = _animations[ANIMATION_TYPE.WAVE]!.value;
              break;
            case ANIMATION_TYPE.SEA: // 바다
              wavePosition = (_animations[ANIMATION_TYPE.SEA] != null)
                  ? _animations[ANIMATION_TYPE.SEA]!.value
                  : 0;
              break;
            case ANIMATION_TYPE.BEACH: // 해변
              wavePosition = (_animations[ANIMATION_TYPE.BEACH] != null)
                  ? _animations[ANIMATION_TYPE.BEACH]!.value
                  : 0;
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
