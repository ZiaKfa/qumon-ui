import 'dart:convert';

import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/helpers/user_info.dart';

class LeaderboardBloc {
  Future fetchRankingData() async {
    String url = ApiUrl.leaderboard;
    var basicAuth = await UserInfo.getAuth();
    var response = await Api().get(url, basicAuth);
    var jsonObj = jsonDecode(response.body);
    return jsonObj['data'] as List<dynamic>;
  }

  Future fetchWeeklyRankingData() async {
    String url = ApiUrl.weekly;
    var basicAuth = await UserInfo.getAuth();
    var response = await Api().get(url, basicAuth);
    var jsonObj = jsonDecode(response.body);
    print(jsonObj);
    return jsonObj['data'] as List<dynamic>;
  }
}
