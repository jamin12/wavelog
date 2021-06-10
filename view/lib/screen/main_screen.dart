import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/widget/blog_state.dart';
import 'package:blog/widget/main_body.dart';
import 'package:blog/widget/main_drawer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final PAGE_TYPE pageType;
  const MainScreen({Key? key, required this.pageType}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BlogState<MainScreen> {
  @override
  late MainBody body;

  @override
  late PAGE_TYPE pageType;

  @override
  late double waveHeight;
  // Side Menu Width
  late double drawerWidth;

  @override
  void initState() {
    super.initState();
    pageType = widget.pageType;
  }

  @override
  Future<void> startAnim(Size size) async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      double changeHeight =
          pageType == PAGE_TYPE.BEACH ? size.height * 0.38 : size.height * 0.62;
      waveHeight = changeHeight;
    });
  }

  @override
  Future<void> changeAnim(Size size, PAGE_TYPE changePageType) async {
    double changeHeight =
        changePageType == PAGE_TYPE.BEACH ? 0 : size.height + 50;

    setState(() {
      waveHeight = changeHeight;
    });

    await Future.delayed(Duration(milliseconds: 800));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(pageType: changePageType),
        ));
  }

  @override
  Widget buildWidget(BuildContext context, Size size) {
    drawerWidth = size.width / 8;
    body = MainBody(
      waveHeight: waveHeight,
      pageType: pageType,
      animationDuration: Duration(milliseconds: 500),
      drawerWidth: drawerWidth,
    );
    return Scaffold(
      body: Row(
        children: [
          MainDrawer(
              pageType: pageType,
              drawerWidth: drawerWidth,
              changeProfile: () {
                changeAnim(
                    size,
                    pageType == PAGE_TYPE.BEACH
                        ? PAGE_TYPE.SEA
                        : PAGE_TYPE.BEACH);
              }),
          Container(
            child: Stack(
              children: [
                body,
              ],
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
}
