import 'dart:convert';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? name, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"name": name, "password": password};
    var response = await Api().post(apiUrl, body);
    print(response.body);
    var jsonObj = json.decode(response.body);
    print(jsonObj);
    return Login.fromJson(jsonObj);
  }
}
