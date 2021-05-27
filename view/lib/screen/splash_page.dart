import 'package:blog/const.dart';
import 'package:blog/screen/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

// 파도, 해변, 바다, 없음
enum ANIMATION_TYPE { WAVE, BEACH, SEA, NONE }

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
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
            end: -size.height / 7 * 5)
        .animate(_controllers[ANIMATION_TYPE.SEA]!)
          ..addListener(() {
            if (_controllers[ANIMATION_TYPE.SEA]!.isAnimating)
              setState(() {});
            else if (_controllers[ANIMATION_TYPE.SEA]!.isCompleted &&
                _animationType != ANIMATION_TYPE.NONE) {
              _animationType = ANIMATION_TYPE.NONE;
              // 바다 이동
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => MainPage(
                        pageType: MAIN_PAGE_TYPE.SEA,
                      )));
            }
          });
    _animations[ANIMATION_TYPE.BEACH] = Tween<double>(
            begin: _animations[ANIMATION_TYPE.WAVE]!.value,
            end: size.height / 2)
        .animate(_controllers[ANIMATION_TYPE.BEACH]!)
          ..addListener(() {
            if (_controllers[ANIMATION_TYPE.BEACH]!.isAnimating)
              setState(() {});
            else if (_controllers[ANIMATION_TYPE.BEACH]!.isCompleted &&
                _animationType != ANIMATION_TYPE.NONE) {
              _animationType = ANIMATION_TYPE.NONE;
              // 해변 이동
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => MainPage(pageType: MAIN_PAGE_TYPE.BEACH)));
            }
          });

    final double waveSize = size.width / (waveCount);

    return Scaffold(
      body: Container(
          color: COLOR_SEA,
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
                      _animationType = ANIMATION_TYPE.BEACH;

                      if (_controllers[ANIMATION_TYPE.WAVE]!.isAnimating)
                        _controllers[ANIMATION_TYPE.WAVE]!.stop();
                      _controllers[ANIMATION_TYPE.BEACH]!.forward();
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: COLOR_DRAWABLE,
                    radius: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/umbrella.svg',
                            width: 100,
                            height: 100,
                            color: COLOR_BEACH,
                          ),
                          Text(
                            'Kang Kyung Min',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: COLOR_BEACH),
                          ),
                        ],
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
                      _animationType = ANIMATION_TYPE.SEA;
                      if (_controllers[ANIMATION_TYPE.WAVE]!.isAnimating)
                        _controllers[ANIMATION_TYPE.WAVE]!.stop();
                      _controllers[ANIMATION_TYPE.SEA]!.forward();
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: COLOR_DRAWABLE,
                    radius: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/fish.svg',
                            width: 100,
                            height: 100,
                            color: COLOR_BEACH,
                          ),
                          Text('Kwon Tae Woong',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: COLOR_BEACH)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
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

          if (index == 0) // 처음 해변
            return Positioned(
              top: wavePosition - waveHeight,
              left: 0,
              right: 0,
              child: Container(
                height: waveHeight * 2,
                color: COLOR_BEACH,
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
                  color: COLOR_BEACH,
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
                  color: COLOR_SEA,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
