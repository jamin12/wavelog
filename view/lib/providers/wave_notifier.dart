import 'package:flutter/material.dart';

class WaveNotifier extends ChangeNotifier {
  // WaveNotifier({Size? size}) : _waveWidth = size.width / 6;

  double _waveWidth = 0;

  double get waveWidth => _waveWidth;

  void changeWaveWidth(double waveWidth) {
    _waveWidth = waveWidth;
    notifyListeners();
  }
}
