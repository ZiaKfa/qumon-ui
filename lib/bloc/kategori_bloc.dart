import 'dart:convert';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/helpers/user_info.dart';

class KategoriBloc {
  Future<List> getKategori() async {
    var basicAuth = await UserInfo.getAuth();
    var response = await Api().get(ApiUrl.kategori, basicAuth);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List listKategori = data['data'];
      print(listKategori);
      return listKategori;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
