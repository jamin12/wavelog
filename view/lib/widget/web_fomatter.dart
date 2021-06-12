import 'package:flutter/material.dart';

class WebFomatter extends StatelessWidget {
  final Widget bodyWidget;
  final Widget? drawerWidget;

  const WebFomatter({
    Key? key,
    required this.bodyWidget,
    this.drawerWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            if (drawerWidget != null)
              Flexible(
                flex: 1,
                child: drawerWidget!,
              ),
            Expanded(
              flex: 7,
              child: bodyWidget,
            ),
          ],
        ),
      ),
    );
  }
}
