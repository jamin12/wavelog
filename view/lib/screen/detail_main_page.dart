import 'package:blog/const.dart';
import 'package:flutter/material.dart';

enum DETAIL_PAGE_TYPE { BEACH, SEA }

class DetailMainPage extends StatefulWidget {
  final DETAIL_PAGE_TYPE pageType;

  DetailMainPage({required this.pageType});

  @override
  _DetailMainPageState createState() => _DetailMainPageState();
}

enum ANIMATION_TYPE { START, WAVE, CHAGE }

class _DetailMainPageState extends State<DetailMainPage>
    with TickerProviderStateMixin {
  // 기본 색상 지정
  late final Color _bgColor;
  late final Color _waveColor;

  // 애니메이션 컨트롤러
  late Map<ANIMATION_TYPE, AnimationController> _controllers;
  // 애니메이션
  late Map<ANIMATION_TYPE, Animation<double>?> _animations;

  late ANIMATION_TYPE _animationType;

  @override
  void initState() {
    super.initState();
    // View Type에 따라 색 지정
    switch (widget.pageType) {
      case DETAIL_PAGE_TYPE.BEACH:
        _bgColor = COLOR_BEACH;
        _waveColor = COLOR_SEA;
        break;
      case DETAIL_PAGE_TYPE.SEA:
        _bgColor = COLOR_SEA;
        _waveColor = COLOR_BEACH;
        break;
      default: // 올 일 없음
        _bgColor = Colors.white;
        _waveColor = Colors.black;
    }
    // 애니메이션 초기 설정 (시작 애니메이션)
    _animationType = ANIMATION_TYPE.START;

    _controllers = {
      ANIMATION_TYPE.WAVE: AnimationController(
          vsync: this, duration: Duration(seconds: 2), value: 0),
      ANIMATION_TYPE.START: AnimationController(
          vsync: this, duration: Duration(seconds: 2), value: 0),
    };

    _animations = {
      ANIMATION_TYPE.WAVE: Tween<double>(begin: 0, end: -20)
          .animate(_controllers[ANIMATION_TYPE.WAVE]!)
            ..addListener(() {
              setState(() {});
            }),
      ANIMATION_TYPE.START: Tween<double>(begin: -100, end: 0)
          .animate(_controllers[ANIMATION_TYPE.START]!)
            ..addListener(() {
              setState(() {});
              if (_controllers[ANIMATION_TYPE.START]!.isCompleted &&
                  _animationType == ANIMATION_TYPE.START) {
                _animationType = ANIMATION_TYPE.WAVE;
                _controllers[ANIMATION_TYPE.WAVE]!.repeat(reverse: true);
              }
            }),
    };

    _controllers[ANIMATION_TYPE.START]!.forward();
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
    final double waveSize = size.width / (waveCount);
    final double waveHeight = 100; // todo : 화면 사이즈에 맞게 유동적으로 변경 필요
    final double waveWidth = waveSize * 1.5;

    late double animationValue;
    switch (_animationType) {
      case ANIMATION_TYPE.START:
        animationValue = _animations[ANIMATION_TYPE.START] != null
            ? _animations[ANIMATION_TYPE.START]!.value
            : 0;
        break;
      case ANIMATION_TYPE.WAVE:
        animationValue = _animations[ANIMATION_TYPE.WAVE] != null
            ? _animations[ANIMATION_TYPE.WAVE]!.value
            : 0;
        break;
      default:
        animationValue = 0;
    }

    return Scaffold(
      backgroundColor: _bgColor,
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: animationValue - waveHeight,
              left: 0,
              right: 0,
              child: Container(
                height: waveHeight * 2,
                color: _waveColor,
              ),
            ),
          ]..addAll(List.generate(waveCount, (index) {
              if (index % 2 == 0) {
                return Positioned(
                  top: animationValue + waveHeight - waveSize / 2 - 3,
                  left: index * waveWidth,
                  child: ClipOval(
                    child: Container(
                      width: waveWidth,
                      height: waveSize,
                      color: _waveColor,
                    ),
                  ),
                );
              } else {
                return Positioned(
                  top: animationValue + waveHeight - waveSize / 2 + 3,
                  left: index * waveWidth,
                  child: ClipOval(
                    child: Container(
                      width: waveWidth,
                      height: waveSize,
                      color: _bgColor,
                    ),
                  ),
                );
              }
            })),
        ),
      ),
    );
  }
}
