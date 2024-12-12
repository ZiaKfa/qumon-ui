import 'dart:convert';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/helpers/user_info.dart';

class ProfilBloc {
  Future getProfil() async {
    var username= await UserInfo.getName();
    var password= await UserInfo.getPassword();
    var basicAuth = base64Encode(utf8.encode('$username:$password'));
    var response = await Api().get(ApiUrl.users, basicAuth);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load profile');
    }
  }
}