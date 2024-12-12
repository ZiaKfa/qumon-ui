import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static Future login(String name, String password) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("name", name);
    pref.setString("password", password);
    pref.setBool("isLogin", true);
  }
  Future logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  static Future<String?> getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("name");
  }

  static Future<String?> getPassword() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("password");
  }

  static Future<bool> isLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("isLogin") ?? false;
  }
}
