import 'package:qumon/Model/answer.dart';
// import 'package:qumon/Model/quiz.dart';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'dart:convert';
import 'package:qumon/helpers/user_info.dart';

class AnswerBloc {
  Future<AnswerResponse> addAnswer(int? quiz_id, String? answer_text) async {
    String url = ApiUrl.answer;
    var basicAuth = UserInfo.getAuth();
    var body = {
      "quiz_id": quiz_id.toString(),
      "answer_text": answer_text,
    };
    var response = await Api().post(url, body, basicAuth);
    var jsonObj = json.decode(response.body);
    return AnswerResponse.fromJson(jsonObj);
  }
}
