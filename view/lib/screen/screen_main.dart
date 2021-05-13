import 'dart:html';
import 'package:blog/screen/wrapper/react_widget_wrapper.dart';
import 'package:blog/widget/widget_drawer.dart';
import 'package:flutter/material.dart';

class ScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _buildContent(context);

  Widget _buildContent(BuildContext context) {
    return ReactWidgetWrapper(
        bodyMain: Container(
          color: Colors.red,
        ),
        bodyDrawer: WidgetDrawer());
  }
}
