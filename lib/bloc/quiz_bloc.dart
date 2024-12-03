import 'package:qumon/Model/quiz.dart';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'dart:convert';

class QuizBloc {
  Future<Quiz> getQuiz() async {
    String url = ApiUrl.quiz;
    var response = await Api().get(url);
    var jsonObj = json.decode(response.body);
    print(jsonObj);
    return Quiz.fromJson(jsonObj);
  }
}
