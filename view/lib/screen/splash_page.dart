import 'package:blog/const.dart';
import 'package:blog/screen/main_page.dart';
import 'package:blog/widget/wave_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

// 파도, 해변, 바다, 없음
enum ANIMATION_TYPE {
  START,
  BEACH,
  SEA,
  BEACH_COMPLETE,
  SEA_COMPLETE,
  CIRCLE_AVARTA
}

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
    _animationType = ANIMATION_TYPE.START;

    // 애니메이션 컨트롤러 초기화
    _controllers = {
      ANIMATION_TYPE.BEACH: AnimationController(
          vsync: this, duration: Duration(milliseconds: 500), value: 0),
      ANIMATION_TYPE.SEA: AnimationController(
          vsync: this, duration: Duration(milliseconds: 500), value: 0),
      ANIMATION_TYPE.CIRCLE_AVARTA: AnimationController(
          vsync: this, duration: Duration(milliseconds: 300), value: 0),
    };

    // 애니메이션 초기화
    _animations = {
      ANIMATION_TYPE.CIRCLE_AVARTA: Tween<double>(begin: 1, end: 0)
          .animate(_controllers[ANIMATION_TYPE.CIRCLE_AVARTA]!),
      ANIMATION_TYPE.BEACH: null,
      ANIMATION_TYPE.SEA: null,
    };
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
    final Size size = MediaQuery.of(context).size;

    _animations[ANIMATION_TYPE.SEA] = Tween<double>(begin: -size.height, end: 0)
        .animate(_controllers[ANIMATION_TYPE.SEA]!)
          ..addListener(() {
            if (_controllers[ANIMATION_TYPE.SEA]!.isCompleted &&
                _animationType != ANIMATION_TYPE.SEA_COMPLETE) {
              _animationType = ANIMATION_TYPE.SEA_COMPLETE;
              // 바다 이동
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => MainPage(
                        pageType: MAIN_PAGE_TYPE.SEA,
                      )));
            }
          });

    _animations[ANIMATION_TYPE.BEACH] = Tween<double>(
            begin: -size.height, end: -size.height * 2)
        .animate(_controllers[ANIMATION_TYPE.BEACH]!)
          ..addListener(() {
            if (_controllers[ANIMATION_TYPE.BEACH]!.isCompleted &&
                _animationType != ANIMATION_TYPE.BEACH_COMPLETE) {
              _animationType = ANIMATION_TYPE.BEACH_COMPLETE;
              // 해변 이동
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => MainPage(pageType: MAIN_PAGE_TYPE.BEACH)));
            }
          });

    return Scaffold(
      body: Container(
          color: COLOR_BEACH,
          child: Stack(
            children: [
              _buildWave(size.height),
              Positioned(
                top: size.height / 10,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _animationType = ANIMATION_TYPE.BEACH;
                      _controllers[ANIMATION_TYPE.BEACH]!.forward();
                      _controllers[ANIMATION_TYPE.CIRCLE_AVARTA]!.forward();
                    });
                  },
                  child: AnimatedBuilder(
                    animation: _animations[ANIMATION_TYPE.CIRCLE_AVARTA]!,
                    builder: (context, child) => Opacity(
                      opacity: _animationType == ANIMATION_TYPE.SEA
                          ? _animations[ANIMATION_TYPE.CIRCLE_AVARTA]!.value
                          : 1,
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
                                BEACH_USER_NAME,
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
                      _controllers[ANIMATION_TYPE.SEA]!.forward();
                      _controllers[ANIMATION_TYPE.CIRCLE_AVARTA]!.forward();
                    });
                  },
                  child: AnimatedBuilder(
                    animation: _animations[ANIMATION_TYPE.CIRCLE_AVARTA]!,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _animationType == ANIMATION_TYPE.BEACH
                            ? _animations[ANIMATION_TYPE.CIRCLE_AVARTA]!.value
                            : 1,
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
                                Text(SEA_USER_NAME,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: COLOR_BEACH)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  /// 일렁이는 파도 및 이동 애니메이션 빌드
  Widget _buildWave(double displayHegiht) {
    return AnimatedBuilder(
      animation: _animationType == ANIMATION_TYPE.SEA
          ? _animations[ANIMATION_TYPE.SEA]!
          : _animations[ANIMATION_TYPE.BEACH]!,
      builder: (context, child) {
        late double _animPosition;

        switch (_animationType) {
          case ANIMATION_TYPE.SEA:
          case ANIMATION_TYPE.SEA_COMPLETE:
            _animPosition = _animations[ANIMATION_TYPE.SEA]!.value;
            break;
          case ANIMATION_TYPE.BEACH:
          case ANIMATION_TYPE.BEACH_COMPLETE:
            _animPosition = _animations[ANIMATION_TYPE.BEACH]!.value;
            break;
          default:
            _animPosition = -(displayHegiht);
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                left: 0,
                right: 0,
                bottom: _animPosition,
                child: Container(
                  height: displayHegiht * 1.5,
                  child: WaveAnimation(
                    waveColor: COLOR_SEA.withBlue(255).withOpacity(0.4),
                    waveSpeed: 5,
                  ),
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: _animPosition,
                child: Container(
                  height: displayHegiht * 1.5,
                  child: WaveAnimation(
                    waveColor: COLOR_SEA.withBlue(200).withOpacity(0.4),
                    waveSpeed: 4,
                  ),
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: _animPosition,
              child: Container(
                height: displayHegiht * 1.5,
                child: WaveAnimation(
                  waveColor: COLOR_SEA.withOpacity(0.4),
                  waveSpeed: 3,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
