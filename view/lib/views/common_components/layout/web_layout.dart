import 'package:blog/const.dart';
import 'package:flutter/material.dart';

class WebLayout extends StatelessWidget {
  final WidgetBuilder mainContents;
  final WidgetBuilder menu;

  const WebLayout({Key? key, required this.mainContents, required this.menu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: COLOR_BACK,
        ), // 배경
        Center(
          child: Container(
            width: size.width / 3 * 2,
            height: size.height / 4 * 3,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30.0),
              elevation: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: this.mainContents(context),
              ),
            ),
          ),
        )
      ],
    );
  }
}
