import 'dart:math';

import 'package:blog/const.dart';
import 'package:flutter/material.dart';

/// Wave Animation Widget
class WaveAnimation extends StatefulWidget {
  final int waveSpeed;
  final bool reverse;
  final Color color;

  const WaveAnimation(
      {Key? key,
      this.waveSpeed = 2,
      this.reverse = false,
      this.color = COLOR_SEA})
      : super(key: key);
  @override
  _WaveAnimationState createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.waveSpeed));
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(widget.reverse
        ? CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutSine)
        : _animationController);
    _animationController.repeat(reverse: widget.reverse);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => ClipPath(
        clipper: WaveClipper(_animation.value),
        child: Container(
          color: widget.color,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [COLOR_BLUE, COLOR_SEA],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //   ),
          // ),
        ),
      ),
    );
  }
}

// Wave Animation 계산 처리
class WaveClipper extends CustomClipper<Path> {
  final double animationValue;

  WaveClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    var p = Path();
    var points = <Offset>[];
    for (var x = 0; x <= size.width; x++) {
      points
          .add(Offset(x.toDouble(), WaveClipper.getYWithX(x, animationValue)));
    }
    p.moveTo(0, WaveClipper.getYWithX(0, animationValue));
    p.addPolygon(points, false);
    p.lineTo(size.width, size.height);
    p.lineTo(0, size.height);
    return p;
  }

  static const double _waveHeight = 50;
  static double getYWithX(int x, double animationValue) {
    // 0 ~ 2pi
    return ((sin(animationValue + x * 0.04) + 1) / 4) * _waveHeight; // 0 ~ 1
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
