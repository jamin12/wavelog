import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/widget/main_background.dart';
import 'package:blog/widget/mobile_fomatter.dart';
import 'package:blog/widget/tablet_fomatter.dart';
import 'package:blog/widget/web_fomatter.dart';
import 'package:flutter/material.dart';

enum VIEW_TYPE { WEB, TABLET, MOBILE }

abstract class BlogState<T extends StatefulWidget> extends State<T> {
  abstract MainBackground bodyBg;
  abstract double waveHeight;
  abstract PAGE_TYPE pageType;
  VIEW_TYPE viewType = VIEW_TYPE.WEB;
  bool initSet = false;
  // debug 용
  final bool _isWeb = identical(0, 0.0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!initSet) {
      initSet = true;
      initSetting(context, size);
    }
    // if (_isWeb)
    //   return WebFomatter(
    //     bodyWidget: buildWidget(context, size),
    //     drawerWidget: buildDrawer(context, size),
    //   );
    if (size.width < MOBILE_WIDTH)
      viewType = VIEW_TYPE.MOBILE;
    else if (size.width > WEB_WIDTH)
      viewType = VIEW_TYPE.WEB;
    else
      viewType = VIEW_TYPE.TABLET;

    return viewFomatter(viewType, size);
  }

  Widget viewFomatter(VIEW_TYPE viewType, Size size) {
    switch (viewType) {
      case VIEW_TYPE.WEB:
        return WebFomatter(
          bodyWidget: buildWidget(context, size),
          drawerWidget: buildDrawer(context, size),
        );
      case VIEW_TYPE.TABLET:
        return WebFomatter(
          bodyWidget: buildWidget(context, size),
          drawerWidget: buildDrawer(context, size),
        );

      case VIEW_TYPE.MOBILE:
        return MobileFomatter(
          bodyWidget: buildWidget(context, size),
          drawerWidget: buildDrawer(context, size),
        );
      default:
        return WebFomatter(
          bodyWidget: buildWidget(context, size),
          drawerWidget: buildDrawer(context, size),
        );
    }
  }

  @protected
  void initSetting(BuildContext context, Size size);

  @protected
  Widget buildWidget(BuildContext context, Size size);

  @protected
  Widget? buildDrawer(BuildContext context, Size size);

  @protected
  Future<void> startAnim(Size size);

  @protected
  Future<void> changeAnim(Size size, PAGE_TYPE changePageType);
}
