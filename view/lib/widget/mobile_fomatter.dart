import 'package:blog/const.dart';
import 'package:flutter/material.dart';

class MobileFomatter extends StatelessWidget {
  final Widget bodyWidget;
  final Widget? drawerWidget;

  const MobileFomatter({
    Key? key,
    required this.bodyWidget,
    this.drawerWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: drawerWidget != null
          ? AppBar(
              iconTheme: IconThemeData(color: COLOR_BEACH),
              backgroundColor: COLOR_DRAWABLE,
            )
          : null,
      body: bodyWidget,
      drawer: (drawerWidget != null)
          ? Drawer(
              child: drawerWidget,
            )
          : null,
    );
  }
}
