import 'package:flutter/material.dart';

class AppContentWrapper extends StatelessWidget {
  final AppBar? appbar;
  final Widget bodyMain;
  final Widget bodyDrawer;

  AppContentWrapper(
      {this.appbar, required this.bodyMain, required this.bodyDrawer});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appbar,
        drawer: Drawer(
          child: bodyDrawer,
        ),
        body: Container(child: bodyMain),
      );
}
