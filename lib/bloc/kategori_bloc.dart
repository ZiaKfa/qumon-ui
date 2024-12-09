import 'dart:convert';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/helpers/user_info.dart';

class KategoriBloc {
  Future<List> getKategori() async {
    var userName = await UserInfo.getName();
    var password = await UserInfo.getPassword();
    var basicAuth = base64Encode(utf8.encode('$userName:$password'));
    var response = await Api().get(ApiUrl.kategori, basicAuth);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List listKategori = data['data'];
      return listKategori;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
