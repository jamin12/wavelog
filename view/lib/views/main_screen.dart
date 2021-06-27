import 'package:blog/const.dart';
import 'package:blog/views/common_components/layout/web_layout.dart';
import 'package:blog/views/page_class_wrapper/page_class.dart';
import 'package:blog/wave_animation.dart';
import 'package:flutter/material.dart';

class MainScreen extends PageClass {
  @override
  Widget appScaffold(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  Widget webScaffold(BuildContext context) {
    return Scaffold(
      body: WebLayout(
        mainContents: (context) => Container(
          color: COLOR_BEACH,
          child: WaveAnimation(
            waveColor: COLOR_SEA,
            waveSpeed: 3,
          ),
        ),
        menu: (context) => Container(),
      ),
    );
  }
}
