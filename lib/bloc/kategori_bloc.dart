import 'dart:convert';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';

class KategoriBloc {
  Future<List> getKategori() async {
    var response = await Api().get(ApiUrl.kategori);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List listKategori = data['data'];
      return listKategori;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
