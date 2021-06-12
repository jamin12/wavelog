import 'package:blog/const.dart';
import 'package:blog/main.dart';
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
  void initState() {
    super.initState();
    pageType = widget.pageType;
  }

  @override
  Future<void> startAnim(Size size) async {
    // 서버 로드 시간
    await Future.delayed(Duration(milliseconds: 500));
    // todo: 여기서 리스트 추가
    setState(() {
      double changeHeight =
          pageType == PAGE_TYPE.BEACH ? size.height * 0.38 : size.height * 0.62;
      waveHeight = changeHeight;
    });
  }

  @override
  Future<void> changeAnim(Size size, PAGE_TYPE changePageType) async {
    // todo: 여기서 리스트 제거
    double changeHeight =
        changePageType == PAGE_TYPE.BEACH ? 0 : size.height + 50;

    setState(() {
      waveHeight = changeHeight;
    });
    // 서버 로드 시간
    await Future.delayed(Duration(milliseconds: 800));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(pageType: changePageType),
        ));
  }

  @override
  Widget buildWidget(BuildContext context, Size size) {
    bodyBg = MainBackground(
      waveHeight: waveHeight,
      pageType: pageType,
      animationDuration: Duration(milliseconds: 500),
    );
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
                itemCount: 5,
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
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 20.0,
                              child: SvgPicture.asset(
                                'assets/fish.svg',
                                color: COLOR_BEACH,
                                width: 20.0,
                                height: 20.0,
                              ),
                            )
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
    startAnim(size);
  }

  @override
  Widget? buildDrawer(BuildContext context, Size size) {
    return MainDrawer(
        pageType: pageType,
        changeProfile: () {
          changeAnim(size,
              pageType == PAGE_TYPE.BEACH ? PAGE_TYPE.SEA : PAGE_TYPE.BEACH);
        });
  }
}
