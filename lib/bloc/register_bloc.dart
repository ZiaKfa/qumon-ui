import 'dart:convert';

import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? name,
    String? email,
    String? password,
  }) async {
    String url = ApiUrl.registrasi;
    var body = {
      "name": name,
      "email": email,
      "password": password,
    };
    var basicAuth = base64Encode(utf8.encode('$name:$password'));

    var response = await Api().post(url, body, basicAuth);
    print("test di bloca");
    print(response.body);
    var jsonObj = json.decode(response.body);
    print(jsonObj);

    return Registrasi.fromJson(jsonObj);
  }
}
