import 'package:blog/utils/const.dart';
import 'package:blog/utils/utils.dart';
import 'package:flutter/material.dart';

class WidgetDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    DISPLAY dpType = Utils.getDisplayType(width);

    return Container(
      height: Size.infinite.height,
      color: Colors.blue,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: dpType == DISPLAY.TABLET ? 30 : 50,
              backgroundColor: Colors.transparent,
              foregroundImage: AssetImage('assets/my.png'),
            ),
            dpType == DISPLAY.TABLET
                ? SelectableText('Kwon Tae Woong')
                : Container(),
          ],
        ),
      ),
    );
  }
}
