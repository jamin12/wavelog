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
  late final Color _bgColor;
  late final Color _waveColor;

  late AnimationController _startingController;

  late AnimationController _waveController;
  late Animation _waveAnimation;
  late Animation _startingAniamtion;

  late ANIMATION_TYPE _animationType;

  @override
  void initState() {
    super.initState();
    //
    switch (widget.pageType) {
      case DETAIL_PAGE_TYPE.BEACH:
        _bgColor = COLOR_BEACH;
        _waveColor = COLOR_SEA;
        break;
      case DETAIL_PAGE_TYPE.SEA:
        _bgColor = COLOR_SEA;
        _waveColor = COLOR_BEACH;
        break;
      default:
        _bgColor = Colors.white;
        _waveColor = Colors.black;
    }

    _animationType = ANIMATION_TYPE.START;

    _waveController = AnimationController(
        vsync: this, duration: Duration(seconds: 2), value: 0);
    _waveAnimation = Tween<double>(begin: 0, end: -20).animate(_waveController)
      ..addListener(() {
        setState(() {});
      });

    _startingController = AnimationController(
        vsync: this, duration: Duration(seconds: 2), value: 0);
    _startingAniamtion =
        Tween<double>(begin: -100, end: 0).animate(_startingController)
          ..addListener(() {
            setState(() {});
            if (_startingController.isCompleted &&
                _animationType == ANIMATION_TYPE.START) {
              _animationType = ANIMATION_TYPE.WAVE;
              _waveController.repeat(reverse: true);
            }
          });

    _startingController.forward();
  }

  @override
  void dispose() {
    _startingController.dispose();
    _waveController.dispose();
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
        animationValue = _startingAniamtion.value;
        break;
      case ANIMATION_TYPE.WAVE:
        animationValue = _waveAnimation.value;
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
