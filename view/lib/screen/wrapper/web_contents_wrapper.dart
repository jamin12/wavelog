import 'package:flutter/material.dart';

class WebContentWrapper extends StatelessWidget {
  final AppBar? appbar;
  final Widget bodyMain;
  final Widget bodyDrawer;

  WebContentWrapper(
      {this.appbar, required this.bodyMain, required this.bodyDrawer});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appbar,
        body: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: bodyDrawer,
                ),
              ),
              Flexible(
                flex: 3,
                child: bodyMain,
              )
            ],
          ),
        ),
      );
}
