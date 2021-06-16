import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/widget/main_background.dart';
import 'package:blog/widget/mobile_fomatter.dart';
import 'package:blog/widget/tablet_fomatter.dart';
import 'package:blog/widget/web_fomatter.dart';
import 'package:flutter/material.dart';

enum VIEW_TYPE { WEB, TABLET, MOBILE }
enum ANIMATION_STATE { STOP, START_ANIM_RUNNING, CHANGE_ANIM_RUNNING }

abstract class BlogState<T extends StatefulWidget> extends State<T> {
  abstract MainBackground bodyBg;
  abstract double waveHeight;
  abstract PAGE_TYPE pageType;
  abstract Duration bgAnimDuration;

  VIEW_TYPE viewType = VIEW_TYPE.WEB;
  bool initSet = false;
  ANIMATION_STATE _bgAnimState = ANIMATION_STATE.STOP;
  PAGE_TYPE _changePageType = PAGE_TYPE.BEACH;
  Widget? _changeWidget;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!initSet) {
      initSet = true;
      initSetting(context, size);
    }

    bodyBg = MainBackground(
        waveHeight: waveHeight,
        pageType: pageType,
        animationDuration: bgAnimDuration,
        onEnd: () {
          var oldAnimState = _bgAnimState;
          _bgAnimState = ANIMATION_STATE.STOP;
          bgAnimationOnEnd(oldAnimState, _changePageType, _changeWidget);
        });

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

  // Animation State 가져오기
  ANIMATION_STATE get currentAnimationState => _bgAnimState;
  // todo: 애니메이션이 멈춰있는지 확인 (애니메이션 구동이 원활하게 될 때 삭제)
  bool get isAnimStop => _bgAnimState == ANIMATION_STATE.STOP;

  // Animation OnEnd
  @protected
  void bgAnimationOnEnd(ANIMATION_STATE oldState, PAGE_TYPE changePageType,
      Widget? changeWidget) {}

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
  @mustCallSuper
  Future<void> startAnim({required Size size}) async {
    _bgAnimState = ANIMATION_STATE.START_ANIM_RUNNING;
  }

  /// 변환 Animation 및 페이지 전환 역할
  @protected
  @mustCallSuper
  Future<void> changeAnim({
    required Size size,
    required PAGE_TYPE changePageType,
    Widget? changeWidget = null,
  }) async {
    this._changePageType = changePageType;
    this._changeWidget = changeWidget;
    _bgAnimState = ANIMATION_STATE.CHANGE_ANIM_RUNNING;
  }
}
