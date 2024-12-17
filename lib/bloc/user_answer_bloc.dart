import 'package:qumon/Model/user_answer.dart';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'dart:convert';
import 'package:qumon/helpers/user_info.dart';

class UserAnswerBloc {
  Future<UserAnswerResponse> addAnswer(
      int? quiz_id, int? user_id, String? answer_text, bool is_correct) async {
    String url = ApiUrl.userAnswer;
    print(url);
    var basicAuth = UserInfo.getAuth();
    var body = {
      "user_id": user_id.toString(),
      "quiz_id": quiz_id.toString(),
      "answer_text": answer_text,
      "is_correct": is_correct ? '1' : '0',
    };
    print(body);
    var response = await Api().post(url, body, basicAuth);
    var jsonObj = json.decode(response.body);
    print(jsonObj);
    return UserAnswerResponse.fromJson(jsonObj);
  }

  Future<UserAnswer> updateUserAnswer(
      int? id, int? quiz_id, int? user_id, String? answer_text) async {
    String url = ApiUrl.userAnswer + '/$id';
    var basicAuth = UserInfo.getAuth();
    var body = {
      "user_id": user_id.toString(),
      "quiz_id": quiz_id.toString(),
      "answer_text": answer_text,
    };
    var response = await Api().put(url, body, basicAuth);
    var jsonObj = json.decode(response.body);
    return UserAnswer.fromJson(jsonObj);
  }
  
}
