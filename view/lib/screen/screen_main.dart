import 'dart:html';

import 'package:blog/widget/web/web_builder.dart';
import 'package:flutter/material.dart';

class ScreenMain extends StatelessWidget {
  bool _isWeb = identical(0, 0.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebBuilder(
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Double K BLOG',
              style: Theme.of(context).textTheme.headline1,
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: false,
            )
          ],
        ),
      ),
    );
  }
}
