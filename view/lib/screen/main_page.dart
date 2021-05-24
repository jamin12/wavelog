import 'package:blog/const.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
        vsync: this, duration: Duration(seconds: 2), value: 0);
    _animation = Tween<double>(begin: -100, end: 0).animate(_waveController)
      ..addListener(() {
        setState(() {});
      });
    _waveController.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    _waveController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int waveCount = 20;
    final double waveSize = size.width / (waveCount / 2);

    return Scaffold(
      body: Container(
        color: COLOR_BEACH,
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(
            waveCount,
            (index) {
              if (index == 0)
                return Positioned(
                  top: _animation.value,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: size.height / 5 * 3,
                    color: COLOR_WAVE,
                  ),
                );

              final int realIndex = index - 1;

              if (index % 2 == 0)
                return Positioned(
                  top: _animation.value + size.height / 5 * 3 - waveSize / 2,
                  left: realIndex * waveSize,
                  child: Container(
                    width: waveSize,
                    height: waveSize,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: COLOR_WAVE),
                  ),
                );
              else {
                return Positioned(
                  top: _animation.value + size.height / 5 * 3 - waveSize / 2,
                  left: realIndex * waveSize,
                  child: Container(
                    width: waveSize,
                    height: waveSize,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: COLOR_BEACH),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
