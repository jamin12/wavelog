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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: WebLayout(
        mainContents: (context) => Container(
          color: COLOR_BEACH,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 10),
                child: SizedBox(
                  width: size.width / 6,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: WaveAnimation(
                      waveSpeed: 2,
                      reverse: false,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: size.width / 6,
                child: Container(
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: size.width / 12,
                          height: size.width / 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: COLOR_BEACH,
                            border: Border.all(
                                color: COLOR_BACK,
                                style: BorderStyle.solid,
                                width: 10.0),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(5.0, 5.0),
                                color: COLOR_BEACH,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: ElevatedButton(
                              onPressed: () {}, child: Text('Hello')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        menu: (context) => Container(),
      ),
    );
  }
}
