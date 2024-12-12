import 'dart:convert';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? name, String? password}) async {
    String apiUrl = ApiUrl.login;
    var basicAuth = base64Encode(utf8.encode('$name:$password'));
    var body = {"name": name, "password": password};
    var response = await Api().post(apiUrl, body, basicAuth);
    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}
