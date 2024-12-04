import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  Future logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
