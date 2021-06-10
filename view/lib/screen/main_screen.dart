import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/widget/blog_state.dart';
import 'package:blog/widget/main_body.dart';
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
  Future<void> changeAnim(Size size, PAGE_TYPE changePageType) async {}

  @override
  Widget buildWidget(BuildContext context) {
    body = MainBody(
      waveHeight: waveHeight,
      pageType: pageType,
      animationDuration: Duration(milliseconds: 500),
      drawerWidth: 300,
    );
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: 300,
            color: COLOR_DRAWABLE,
          ),
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
  void initSetting(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    waveHeight = pageType == PAGE_TYPE.BEACH ? 0 : size.height + 50;
    startAnim(size);
  }
}
