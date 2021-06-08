import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/widget/wave_animation.dart';
import 'package:flutter/material.dart';

class MainBody extends StatelessWidget {
  final double waveHeight;
  final PAGE_TYPE pageType;
  final Duration animationDuration;

  MainBody({
    Key? key,
    required this.waveHeight,
    required this.pageType,
    required this.animationDuration,
  }) : super(key: key);

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
              duration: animationDuration,
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
