import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/model/bean_item.dart';
import 'package:blog/screen/main_screen.dart';
import 'package:blog/widget/blog_state.dart';
import 'package:blog/widget/main_background.dart';
import 'package:blog/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostScreen extends StatefulWidget {
  final PAGE_TYPE pageType;
  final BeanItem category;
  final List<BeanItem> categorys;
  const PostScreen({
    Key? key,
    required this.pageType,
    required this.category,
    required this.categorys,
  }) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends BlogState<PostScreen> {
  @override
  late MainBackground bodyBg;

  @override
  late PAGE_TYPE pageType;

  @override
  late double waveHeight;

  @override
  late Duration bgAnimDuration;

  late List<BeanItem> _tempContentsData;

  @override
  void initState() {
    super.initState();
    pageType = widget.pageType;
    _tempContentsData = List.generate(
        100,
        (index) => BeanItem(
            id: '$index',
            title: '$index title',
            contents: '$index contents',
            views: index,
            writeDate: '2021-06-14 23:20'));
    bgAnimDuration = Duration(milliseconds: 500);
  }

  @override
  Future<void> startAnim({required Size size}) async {
    super.startAnim(size: size);
    // 서버 로드 시간
    await Future.delayed(Duration(milliseconds: 500));
    // todo: 여기서 리스트 추가
    setState(() {
      double changeHeight =
          pageType == PAGE_TYPE.BEACH ? size.height * 0.2 : size.height * 0.8;
      waveHeight = changeHeight;
    });
  }

  @override
  Future<void> changeAnim(
      {required Size size,
      required PAGE_TYPE changePageType,
      Widget? changeWidget = null}) async {
    super.changeAnim(
        size: size, changePageType: changePageType, changeWidget: changeWidget);
    // todo: 여기서 리스트 제거
    double changeHeight =
        changePageType == PAGE_TYPE.BEACH ? 0 : size.height + 50;

    setState(() {
      waveHeight = changeHeight;
    });
  }

  @override
  void bgAnimationOnEnd(ANIMATION_STATE oldState, PAGE_TYPE changePageType,
      Widget? changeWidget) {
    if (oldState == ANIMATION_STATE.CHANGE_ANIM_RUNNING) {
      if (changeWidget == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(pageType: changePageType),
          ),
        );
      } else
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => changeWidget,
          ),
        );
    }
  }

  @override
  Widget buildWidget(BuildContext context, Size size) {
    return Scaffold(
      body: Stack(
        children: [
          bodyBg,
          Container(
            child: ListView(
              padding: viewType == VIEW_TYPE.WEB
                  ? EdgeInsets.symmetric(horizontal: size.width / 7)
                  : viewType == VIEW_TYPE.TABLET
                      ? EdgeInsets.symmetric(horizontal: size.width / 10)
                      : EdgeInsets.symmetric(horizontal: size.width / 20),
              physics: BouncingScrollPhysics(),
              children: _buildMainItem(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: COLOR_DRAWABLE,
        onPressed: () {},
        child: Icon(
          Icons.edit,
          color: COLOR_BEACH,
        ),
      ),
    );
  }

  List<Widget> _buildMainItem() {
    var list = [
      viewType == VIEW_TYPE.MOBILE
          ? const SizedBox(
              height: 50,
            )
          : const SizedBox(
              height: 100.0,
            ),
      Row(
        children: [
          CircleAvatar(
            backgroundColor: widget.category.color,
            radius: 30,
            child: SvgPicture.asset(
              'assets/${pageType == PAGE_TYPE.BEACH ? 'umbrella' : 'fish'}.svg',
              color: COLOR_BEACH,
              width: 30,
              height: 30,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              widget.category.title,
              style: TextStyle(fontSize: 30.0, color: COLOR_DRAWABLE),
            ),
          ),
        ],
      ),
      Divider(
        color: COLOR_DRAWABLE,
        thickness: 1.0,
        height: 30.0,
      ),
    ];

    list.addAll(_tempContentsData.map((bean) => Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  child: Text(
                    bean.id,
                    style: TextStyle(fontSize: 10.0, color: COLOR_DRAWABLE),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      bean.title,
                      style: TextStyle(fontSize: 20.0, color: COLOR_DRAWABLE),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    bean.writeDate,
                    style: TextStyle(fontSize: 15.0, color: COLOR_DRAWABLE),
                  ),
                ),
              ],
            ),
            Divider(
              height: 10.0,
              thickness: 1.0,
              color: COLOR_DRAWABLE,
            )
          ],
        )));

    return list;
  }

  @override
  void initSetting(BuildContext context, Size size) {
    waveHeight = pageType == PAGE_TYPE.BEACH ? 0 : size.height + 50;
    startAnim(size: size);
  }

  @override
  Widget? buildDrawer(BuildContext context, Size size) {
    return MainDrawer(
      pageType: pageType,
      drawers: Map.fromIterables(
        widget.categorys,
        List.generate(
          widget.categorys.length,
          (index) => () {
            if (isAnimStop)
              changeAnim(
                size: size,
                changePageType: pageType,
                changeWidget: PostScreen(
                  pageType: pageType,
                  category: widget.categorys[index],
                  categorys: widget.categorys,
                ),
              );
          },
        ),
      ),
      myProfile: () {
        if (isAnimStop)
          changeAnim(
            size: size,
            changePageType: pageType,
          );
      },
      changeProfile: () {
        if (isAnimStop)
          changeAnim(
            size: size,
            changePageType:
                pageType == PAGE_TYPE.BEACH ? PAGE_TYPE.SEA : PAGE_TYPE.BEACH,
          );
      },
    );
  }
}
