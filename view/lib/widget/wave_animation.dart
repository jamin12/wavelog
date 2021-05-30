import 'dart:math';

import 'package:flutter/material.dart';

class WaveAnimation extends StatefulWidget {
  final Color waveColor;
  final int waveSpeed;
  final bool reverse;

  const WaveAnimation(
      {Key? key,
      required this.waveColor,
      this.waveSpeed = 2,
      this.reverse = false})
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
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat(reverse: widget.reverse);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(_animation.value),
      child: Container(
        color: widget.waveColor,
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animationValue;

  WaveClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    var p = Path();
    var points = <Offset>[];
    for (var x = 0; x < size.width; x++) {
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
    return ((sin(animationValue + x * 0.01) + 1) / 2) * _waveHeight; // 0 ~ 1
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
