import 'package:blog/screen/splash_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(Blog());

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Blog',
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        home: SplashPage(),
      );
}
