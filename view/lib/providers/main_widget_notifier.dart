import 'package:blog/views/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class MainWidgetNotifier extends ChangeNotifier {
  MAIN_WIDGET _mainWidget = MAIN_WIDGET.MAIN;

  void changeMainWidget(MAIN_WIDGET widget) {
    if (_mainWidget != widget) {
      _mainWidget = widget;
      notifyListeners();
    }
  }

  MAIN_WIDGET get mainWidget => _mainWidget;
}
