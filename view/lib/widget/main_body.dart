import 'package:blog/const.dart';
import 'package:blog/screen/main_page.dart';
import 'package:blog/widget/wave_animation.dart';

import 'package:flutter/material.dart';

class MainBody extends StatefulWidget {
  final MAIN_PAGE_TYPE pageType;
  final Size bodySize;
  MainBody({required this.pageType, required this.bodySize});

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> with TickerProviderStateMixin {
  late final double bodyHeight;

  // 기본 색상 지정
  late final Color _bgColor = COLOR_BEACH;
  late final Color _waveColor = COLOR_SEA;

  // 애니메이션 컨트롤러
  late Map<ANIMATION_TYPE, AnimationController> _controllers;
  // 애니메이션
  late Map<ANIMATION_TYPE, Animation<double>?> _animations;

  late ANIMATION_TYPE _animationType;

  @override
  void initState() {
    super.initState();
    bodyHeight = widget.bodySize.height;
    // 애니메이션 초기 설정 (시작 애니메이션)
    _animationType = ANIMATION_TYPE.START;

    _controllers = {
      ANIMATION_TYPE.START: AnimationController(
          vsync: this, duration: Duration(seconds: 1), value: 0),
    };

    _animations = {
      ANIMATION_TYPE.START: Tween<double>(
              begin: (widget.pageType == MAIN_PAGE_TYPE.SEA)
                  ? -bodyHeight * 0.3
                  : -bodyHeight * 1.7,
              end: (widget.pageType == MAIN_PAGE_TYPE.SEA)
                  ? -bodyHeight * 0.6
                  : -bodyHeight * 1.35)
          .animate(_controllers[ANIMATION_TYPE.START]!)
            ..addListener(() {
              setState(() {
                if (_controllers[ANIMATION_TYPE.START]!.isCompleted &&
                    _animationType != ANIMATION_TYPE.NONE) {
                  _animationType = ANIMATION_TYPE.NONE;
                }
              });
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

  // 파도 애니메이션 빌드
  List<Widget> buildWaveAnimation() {
    late double animationValue = widget.pageType == MAIN_PAGE_TYPE.SEA
        ? -bodyHeight * 0.6
        : -bodyHeight * 1.35;
    List<Widget> _list = [];

    if (_animationType == ANIMATION_TYPE.START)
      animationValue = _animations[ANIMATION_TYPE.START]!.value;

    _list.add(
      Positioned(
        left: 0,
        right: 0,
        bottom:
            (widget.pageType == MAIN_PAGE_TYPE.BEACH) ? null : animationValue,
        top: (widget.pageType == MAIN_PAGE_TYPE.SEA) ? null : animationValue,
        child: Container(
          height: bodyHeight * 1.5,
          child: RotatedBox(
            quarterTurns: (widget.pageType == MAIN_PAGE_TYPE.BEACH) ? 2 : 0,
            child: WaveAnimation(
              waveColor: _waveColor.withBlue(255).withOpacity(0.4),
              waveSpeed: 5,
            ),
          ),
        ),
      ),
    );

    _list.add(
      Positioned(
        left: 0,
        right: 0,
        bottom:
            (widget.pageType == MAIN_PAGE_TYPE.BEACH) ? null : animationValue,
        top: (widget.pageType == MAIN_PAGE_TYPE.SEA) ? null : animationValue,
        child: Container(
          height: bodyHeight * 1.5,
          child: RotatedBox(
            quarterTurns: (widget.pageType == MAIN_PAGE_TYPE.BEACH) ? 2 : 0,
            child: WaveAnimation(
              waveColor: _waveColor.withBlue(200).withOpacity(0.4),
              waveSpeed: 4,
            ),
          ),
        ),
      ),
    );

    _list.add(
      Positioned(
        left: 0,
        right: 0,
        bottom:
            (widget.pageType == MAIN_PAGE_TYPE.BEACH) ? null : animationValue,
        top: (widget.pageType == MAIN_PAGE_TYPE.SEA) ? null : animationValue,
        child: Container(
          height: bodyHeight * 1.5,
          child: RotatedBox(
            quarterTurns: (widget.pageType == MAIN_PAGE_TYPE.BEACH) ? 2 : 0,
            child: WaveAnimation(
              waveColor: widget.pageType == MAIN_PAGE_TYPE.SEA
                  ? _waveColor.withOpacity(0.4)
                  : _waveColor,
              waveSpeed: 3,
            ),
          ),
        ),
      ),
    );

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    // switch (_animationType) {
    //   case ANIMATION_TYPE.START:
    //     // animationValue = _animations[ANIMATION_TYPE.START] != null
    //     //     ? _animations[ANIMATION_TYPE.START]!.value
    //     //     : 0;
    //     break;

    //   default:
    //     animationValue = 0;
    // }

    return Container(
      width: widget.bodySize.width,
      color: _bgColor,
      child: Stack(children: buildWaveAnimation()),
    );
  }
}
