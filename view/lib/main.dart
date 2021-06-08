import 'package:blog/screen/splash_screen.dart';
import 'package:flutter/material.dart';

enum ANIMATION_TYPE { START, CHANGE, NONE }
enum PAGE_TYPE { BEACH, SEA }

void main() => runApp(Blog());

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wavelog',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: SplashScreen(),
    );
  }
}
