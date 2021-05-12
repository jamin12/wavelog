import 'package:blog/screen/screen_about.dart';
import 'package:blog/screen/screen_error.dart';
import 'package:blog/screen/screen_main.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyBlog());

class MyBlog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/') {
          // 메인 페이지
          return MaterialPageRoute(
            settings: RouteSettings(name: '/'),
            maintainState: false,
            builder: (context) => ScreenMain(),
          );
        } else {
          Uri uri = Uri.parse(settings.name!);
          print(uri.pathSegments.first.toString());
          if (uri.pathSegments.first == 'about') {
            // 개발자 정보 페이지
            return MaterialPageRoute(
              maintainState: false,
              settings: RouteSettings(name: '/about'),
              builder: (context) => ScreenAbout(),
            );
          }
        }
        // 사용자가 의도치 않은 페이지를 이동했을 경우 Error 페이지로 이동
        return MaterialPageRoute(
          maintainState: false,
          settings: RouteSettings(name: '/error'),
          builder: (context) => ScreenError(),
        );
      },
    );
  }
}
