import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/model/bean_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainDrawer extends StatelessWidget {
  final PAGE_TYPE pageType;
  final Map<BeanItem, Function()>? drawers;
  final Function() changeProfile;
  final Function() myProfile;

  const MainDrawer({
    Key? key,
    required this.pageType,
    this.drawers = null,
    required this.myProfile,
    required this.changeProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (size.width < MOBILE_WIDTH)
      return _buildMobile(context);
    else if (size.width > WEB_WIDTH) {
      if (size.width < 1530) return _buildTablet(context);
      return _buildWeb(context);
    } else
      return _buildTablet(context);
  }

  // 카테고리 빌드
  List<Widget> _buildCategorys(BuildContext context,
      {required bool isSmall, required bool isMobile}) {
    List<Widget> _list = [];
    if (drawers != null) {
      drawers!.forEach((bean, onTap) {
        _list.add(Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: isSmall
              ? InkWell(
                  onTap: onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: bean.color,
                          child: SvgPicture.asset(
                            'assets/${pageType == PAGE_TYPE.BEACH ? 'umbrella' : 'fish'}.svg',
                            color: COLOR_DRAWABLE,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListTile(
                  onTap: isMobile
                      ? () {
                          Navigator.pop(context);
                          onTap();
                        }
                      : onTap,
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: bean.color,
                    child: SvgPicture.asset(
                      'assets/${pageType == PAGE_TYPE.BEACH ? 'umbrella' : 'fish'}.svg',
                      color: COLOR_DRAWABLE,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  title: Text(
                    bean.title,
                    style: TextStyle(color: COLOR_BEACH, fontSize: 15),
                  ),
                ),
        ));
      });
    }
    return _list;
  }

  // 웹 뷰
  Widget _buildWeb(BuildContext context) {
    return _buildBigDrawer(context);
  }

  // 태블릿 뷰
  Widget _buildTablet(BuildContext context) {
    return _buildSmallDrawer(context);
  }

  // 모바일 뷰
  Widget _buildMobile(BuildContext context) {
    return _buildBigDrawer(context, true);
  }

  Container _buildBigDrawer(BuildContext context, [bool isMobile = false]) {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
      color: COLOR_DRAWABLE,
      height: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            ListTile(
              onTap: isMobile
                  ? () {
                      Navigator.pop(context);
                      myProfile();
                    }
                  : myProfile,
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: COLOR_BEACH,
                child: SvgPicture.asset(
                  'assets/${pageType == PAGE_TYPE.BEACH ? 'umbrella' : 'fish'}.svg',
                  color: COLOR_DRAWABLE,
                  width: 25,
                  height: 25,
                ),
              ),
              title: Text(
                '${pageType == PAGE_TYPE.BEACH ? BEACH_USER_NAME : SEA_USER_NAME}',
                style: TextStyle(color: COLOR_BEACH, fontSize: 15),
              ),
            ),
            Divider(
              color: COLOR_BEACH,
              height: 50.0,
              thickness: 1.0,
            ),
            ListTile(
              onTap: isMobile
                  ? () {
                      Navigator.pop(context);
                      changeProfile();
                    }
                  : changeProfile,
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: COLOR_BEACH,
                child: SvgPicture.asset(
                  'assets/${pageType == PAGE_TYPE.SEA ? 'umbrella' : 'fish'}.svg',
                  color: COLOR_DRAWABLE,
                  width: 25,
                  height: 25,
                ),
              ),
              title: Text(
                '${pageType == PAGE_TYPE.SEA ? BEACH_USER_NAME : SEA_USER_NAME}',
                style: TextStyle(color: COLOR_BEACH, fontSize: 15),
              ),
            ),
          ]..addAll(
              _buildCategorys(context, isSmall: false, isMobile: isMobile)),
        ),
      ),
    );
  }

  Container _buildSmallDrawer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.only(top: 30.0),
      color: COLOR_DRAWABLE,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: myProfile,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: COLOR_BEACH,
                        child: SvgPicture.asset(
                          'assets/${pageType == PAGE_TYPE.BEACH ? 'umbrella' : 'fish'}.svg',
                          color: COLOR_DRAWABLE,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: COLOR_BEACH,
                  height: 50.0,
                  thickness: 1.0,
                ),
              ),
              InkWell(
                onTap: changeProfile,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: COLOR_BEACH,
                        child: SvgPicture.asset(
                          'assets/${pageType == PAGE_TYPE.SEA ? 'umbrella' : 'fish'}.svg',
                          color: COLOR_DRAWABLE,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]..addAll(_buildCategorys(context, isSmall: true, isMobile: false)),
          ),
        ),
      ),
    );
  }
}
