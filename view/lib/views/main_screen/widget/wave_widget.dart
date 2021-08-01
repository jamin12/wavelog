import 'package:blog/providers/wave_notifier.dart';
import 'package:blog/wave_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildWave extends StatefulWidget {
  final double initWaveSize;

  const BuildWave(
    this.initWaveSize, {
    Key? key,
  }) : super(key: key);

  @override
  _BuildWaveState createState() => _BuildWaveState();
}

class _BuildWaveState extends State<BuildWave> {
  late double waveWidth;
  @override
  void initState() {
    super.initState();
    waveWidth = widget.initWaveSize;
  }

  @override
  Widget build(BuildContext context) {
    waveWidth = (context.watch<WaveNotifier>().waveWidth > 0)
        ? context.watch<WaveNotifier>().waveWidth
        : waveWidth;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: waveWidth,
      curve: Curves.decelerate,
      child: RotatedBox(
        quarterTurns: 1,
        child: WaveAnimation(
          waveSpeed: 2,
          reverse: false,
        ),
      ),
    );
  }
}
