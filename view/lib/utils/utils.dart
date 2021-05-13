import 'package:blog/utils/const.dart';
import 'package:flutter/material.dart';

class Utils {
  static DISPLAY getDisplayType(double width) {
    if (width > 1000)
      return DISPLAY.WEB;
    else if (width < 430)
      return DISPLAY.MOBILE;
    else
      return DISPLAY.TABLET;
  }
}
