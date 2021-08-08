import 'package:blog/providers/main_widget_notifier.dart';
import 'package:blog/providers/wave_notifier.dart';
import 'package:blog/views/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ANIMATION_TYPE { START, CHANGE, NONE }
enum PAGE_TYPE { BEACH, SEA }

/// 모든 프로그램의 시작
void main() => runApp(Blog());

/// Blog 프로그램의 첫 시작
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
            builder: (_) {
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider<MainWidgetNotifier>(
                      create: (_) => MainWidgetNotifier()),
                  ChangeNotifierProvider<WaveNotifier>(
                    create: (context) => WaveNotifier(),
                  ),
                ],
                child: MainScreen(), // 기본이 되는 스크린
              );
            },
          );
        }
      },
    );
  }
}
