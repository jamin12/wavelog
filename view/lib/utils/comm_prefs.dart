import 'package:blog/utils/comm_prefs_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comm_Prefs {
  static SharedPreferences? prefs;

  static Future<SharedPreferences?> newInstance() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static getInstance() async {
    if (prefs == null) prefs = await newInstance();
    return prefs;
  }

  // 로그인 여부 가져오기
  static getIsLogin() {
    return prefs!.getBool(Comm_Prefs_Params.isLogin);
  }

  // 로그인 여부 저장
  static setIsLogin(bool value) {
    return prefs!
        .setBool(Comm_Prefs_Params.isLogin, value)
        .then((bool success) => success);
  }
}
