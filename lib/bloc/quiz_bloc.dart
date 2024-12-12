import 'package:qumon/Model/quiz.dart';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'dart:convert';

import 'package:qumon/helpers/user_info.dart';

class QuizBloc {
  Future<Quiz> getQuiz() async {
    String url = ApiUrl.quiz;
    var userName = await UserInfo.getName();
    var password = await UserInfo.getPassword();
    print(userName);
    print(password);
    var basicAuth = base64Encode(utf8.encode('$userName:$password'));
    print(basicAuth);
    var response = await Api().get(url,basicAuth);
    var jsonObj = json.decode(response.body);
    print(jsonObj);
    return Quiz.fromJson(jsonObj);
  }
}
