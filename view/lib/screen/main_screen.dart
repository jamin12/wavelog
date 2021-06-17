import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/model/bean_item.dart';
import 'package:blog/screen/category_screen.dart';
import 'package:blog/widget/blog_state.dart';
import 'package:blog/widget/main_background.dart';
import 'package:blog/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  final PAGE_TYPE pageType;
  const MainScreen({Key? key, required this.pageType}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BlogState<MainScreen> {
  @override
  late MainBackground bodyBg;

  @override
  late PAGE_TYPE pageType;

  @override
  late double waveHeight;

  @override
  late Duration bgAnimDuration;
  // todo: 임시 데이터
  late List<BeanItem> _tempCategoryData;

  @override
  void initState() {
    super.initState();
    pageType = widget.pageType;
    // todo : 임시 데이터 추가
    _tempCategoryData = List<BeanItem>.generate(
      4,
      (index) => BeanItem(
          id: '$index',
          color: Colors.accents[index % Colors.accents.length],
          title: '$index'),
    );
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
      // 0.38 / 0.62
      waveHeight = changeHeight;
    });
  }

  @override
  Future<void> changeAnim({
    required Size size,
    required PAGE_TYPE changePageType,
    Widget? changeWidget = null,
  }) async {
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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: 100,
                left: viewType == VIEW_TYPE.MOBILE
                    ? size.width / 10
                    : viewType == VIEW_TYPE.TABLET
                        ? size.width / 10
                        : size.width / 7,
                right: viewType == VIEW_TYPE.MOBILE
                    ? size.width / 10
                    : viewType == VIEW_TYPE.TABLET
                        ? size.width / 10
                        : size.width / 7,
                bottom: 20.0,
              ),
              child: GridView.builder(
                itemCount: _tempCategoryData.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: viewType == VIEW_TYPE.MOBILE
                        ? 1
                        : viewType == VIEW_TYPE.TABLET
                            ? 2
                            : 3,
                    childAspectRatio: 5 / 7, // width / height
                    crossAxisSpacing: 30.0,
                    mainAxisSpacing: 20.0,
                    mainAxisExtent: size.height / 3),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: COLOR_BEACH,
                    border: Border.all(width: 1.0, color: COLOR_DRAWABLE),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (isAnimStop)
                          changeAnim(
                            size: size,
                            changePageType: pageType,
                            changeWidget: CategoryScreen(
                              pageType: pageType,
                              category: _tempCategoryData[index],
                              categorys: _tempCategoryData,
                            ),
                          );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: _tempCategoryData[index].color,
                              radius: 20.0,
                              child: SvgPicture.asset(
                                'assets/${pageType == PAGE_TYPE.BEACH ? 'umbrella' : 'fish'}.svg',
                                color: COLOR_BEACH,
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                            Expanded(
                                child: Center(
                                    child: Text(
                              _tempCategoryData[index].title,
                              style: TextStyle(fontSize: 20.0), // todo : 임시 사이즈
                            )))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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

  @override
  void initSetting(BuildContext context, Size size) {
    waveHeight = pageType == PAGE_TYPE.BEACH ? 0 : size.height + 50;
    startAnim(size: size);
  }

  @override
  Widget? buildDrawer(BuildContext context, Size size) {
    return MainDrawer(
      drawers: Map.fromIterables(
        _tempCategoryData,
        List.generate(
          _tempCategoryData.length,
          (index) => () {
            if (isAnimStop)
              changeAnim(
                size: size,
                changePageType: pageType,
                changeWidget: CategoryScreen(
                  pageType: pageType,
                  category: _tempCategoryData[index],
                  categorys: _tempCategoryData,
                ),
              );
          },
        ),
      ),
      pageType: pageType,
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
