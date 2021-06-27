import 'package:blog/views/main_screen.dart';
import 'package:flutter/material.dart';

enum ANIMATION_TYPE { START, CHANGE, NONE }
enum PAGE_TYPE { BEACH, SEA }

void main() => runApp(Blog());

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wavelog',
      initialRoute: '/',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            settings: RouteSettings(name: '/'),
            maintainState: false,
            builder: (context) {
              return MainScreen();
            },
          );
        }
      },
    );
  }
}
