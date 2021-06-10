import 'package:blog/const.dart';
import 'package:blog/main.dart';
import 'package:blog/model/bean_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainDrawer extends StatelessWidget {
  final PAGE_TYPE pageType;
  final Map<BeanItem, Function()>? drawers;
  final double drawerWidth;
  final Function() changeProfile;
  // debug 용
  final bool _isWeb = identical(0, 0.0);
  const MainDrawer({
    Key? key,
    required this.pageType,
    this.drawers,
    required this.drawerWidth,
    required this.changeProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_isWeb) _buildWeb();
    if (size.width < MOBILE_WIDTH)
      return _buildMobile();
    else if (size.width > WEB_WIDTH)
      return _buildWeb();
    else
      return _buildTablet();
  }

  // 웹 뷰
  Widget _buildWeb() {
    return Container(
      width: drawerWidth,
      padding: const EdgeInsets.only(top: 30.0, left: 5.0, right: 10.0),
      color: COLOR_DRAWABLE,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
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
                Text(
                  '${pageType == PAGE_TYPE.BEACH ? BEACH_USER_NAME : SEA_USER_NAME}',
                  style: TextStyle(color: COLOR_BEACH, fontSize: 15),
                )
              ],
            ),
            Divider(
              color: COLOR_BEACH,
              indent: 10.0,
              thickness: 1.0,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: changeProfile,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
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
                    Text(
                      '${pageType == PAGE_TYPE.SEA ? BEACH_USER_NAME : SEA_USER_NAME}',
                      style: TextStyle(color: COLOR_BEACH, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 태블릿 뷰
  Widget _buildTablet() {
    return Container();
  }

  // 모바일 뷰
  Widget _buildMobile() {
    return Container();
  }
}
