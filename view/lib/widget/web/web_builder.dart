import 'package:blog/utils/comm_colors.dart';
import 'package:flutter/material.dart';

class WebBuilder extends StatelessWidget {
  final Widget bodyWidget;
  WebBuilder({required this.bodyWidget});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: size.width / 8),
            Expanded(
              child: Container(
                child: bodyWidget,
                color: Colors.white,
              ),
            ),
            SizedBox(width: size.width / 8),
          ],
        ),
      ),
    );
  }
}
