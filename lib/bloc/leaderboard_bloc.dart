import 'dart:convert';

import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/helpers/user_info.dart';

class LeaderboardBloc {
  Future fetchRankingData() async {
    String url = ApiUrl.leaderboard;
    var userName = await UserInfo.getName();
    var password = await UserInfo.getPassword();
    var basicAuth = base64Encode(utf8.encode('$userName:$password'));
    var response = await Api().get(url, basicAuth);
    var jsonObj = jsonDecode(response.body);
    return jsonObj['data'] as List<dynamic>;
  }

  Future fetchWeeklyRankingData() async {
    String url = ApiUrl.weekly;
    var userName = await UserInfo.getName();
    var password = await UserInfo.getPassword();
    var basicAuth = base64Encode(utf8.encode('$userName:$password'));
    var response = await Api().get(url, basicAuth);
    var jsonObj = jsonDecode(response.body);
    print(jsonObj);
    return jsonObj['data'] as List<dynamic>;
  }
}
