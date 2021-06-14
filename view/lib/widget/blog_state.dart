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

  /// View Fomatter
  Widget viewFomatter(VIEW_TYPE viewType, Size size) {
    switch (viewType) {
      case VIEW_TYPE.WEB:
        return WebFomatter(
          bodyWidget: buildWidget(context, size),
          drawerWidget: buildDrawer(context, size),
        );
      case VIEW_TYPE.TABLET:
        return TabletFomatter(
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

  /// Initialized Setting
  @protected
  void initSetting(BuildContext context, Size size);

  /// Main Widget Build
  @protected
  Widget buildWidget(BuildContext context, Size size);

  /// Drawer Build
  @protected
  Widget? buildDrawer(BuildContext context, Size size);

  /// 시작 Animation
  @protected
  Future<void> startAnim({required Size size});

  /// 변환 Animation 및 페이지 전환 역할
  @protected
  Future<void> changeAnim({
    required Size size,
    required PAGE_TYPE changePageType,
    Widget? changeWidget = null,
  });
}
