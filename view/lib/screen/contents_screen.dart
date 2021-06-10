import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/widget/blog_state.dart';
import 'package:blog/widget/main_body.dart';
import 'package:flutter/material.dart';

class ContentsScreen extends StatefulWidget {
  final PAGE_TYPE pageType;
  const ContentsScreen({Key? key, required this.pageType}) : super(key: key);

  @override
  _ContentsScreenState createState() => _ContentsScreenState();
}

class _ContentsScreenState extends BlogState<ContentsScreen> {
  @override
  late MainBody body;

  @override
  late PAGE_TYPE pageType;

  @override
  late double waveHeight;

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
  Future<void> changeAnim(Size size, PAGE_TYPE changePageType) async {}

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
          Container(
            height: double.infinity,
            width: drawerWidth,
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
  void initSetting(BuildContext context, Size size) {
    waveHeight = pageType == PAGE_TYPE.BEACH ? 0 : size.height + 50;
    startAnim(size);
  }
}
