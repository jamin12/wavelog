import 'package:blog/screen/wrapper/app_contents_wrapper.dart';
import 'package:blog/screen/wrapper/tablet_contents_wrapper.dart';
import 'package:blog/screen/wrapper/web_contents_wrapper.dart';
import 'package:flutter/material.dart';

class ReactWidgetWrapper extends StatelessWidget {
  final AppBar? appbar;
  final Widget bodyMain;
  final Widget bodyDrawer;

  ReactWidgetWrapper(
      {this.appbar, required this.bodyMain, required this.bodyDrawer});

  bool _isWeb = identical(0, 0.0);

  @override
  Widget build(BuildContext context) => _buildContext(context);

  Widget _buildContext(BuildContext context) {
    // if (_isWeb)
    //   return WebContentWrapper(bodyMain: bodyMain, bodyDrawer: bodyDrawer);
    // else {

    // }
    double dpWidth = MediaQuery.of(context).size.width;
    if (dpWidth > 1000)
      return WebContentWrapper(bodyMain: bodyMain, bodyDrawer: bodyDrawer);
    else if (dpWidth < 430)
      return AppContentWrapper(bodyMain: bodyMain, bodyDrawer: bodyDrawer);
    else
      return TabletContentWrapper(bodyMain: bodyMain, bodyDrawer: bodyDrawer);
  }
}
