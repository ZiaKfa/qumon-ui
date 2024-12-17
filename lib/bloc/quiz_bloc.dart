import 'package:qumon/Model/quiz.dart';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'dart:convert';

import 'package:qumon/helpers/user_info.dart';

class QuizBloc {
  Future<Quiz> getQuiz() async {
    String url = ApiUrl.quiz;
    var basicAuth = UserInfo.getAuth();
    print(basicAuth);
    var response = await Api().get(url, basicAuth);
    var jsonObj = json.decode(response.body);
    return Quiz.fromJson(jsonObj);
  }

  Future<CreateQuizResponse> addNewQuiz(
      int? userId, int? idCategory, String? question) async {
    String url = ApiUrl.quiz;
    var basicAuth = UserInfo.getAuth();
    var body = {
      "user_id": userId.toString(),
      "question": question,
      "category_id": idCategory.toString(),
      "is_private": '0'
    };
    print(body);
    var response = await Api().post(url, body, basicAuth);
    var jsonObj = json.decode(response.body);

    return CreateQuizResponse.fromJson(jsonObj);
  }

  Future<Quiz> getQuizById(int? id) async {
    String url = ApiUrl.quiz + '/$id';
    var basicAuth = UserInfo.getAuth();
    var response = await Api().get(url, basicAuth);
    print(response.body);
    var jsonObj = json.decode(response.body);
    print(jsonObj);
    return Quiz.fromJson(jsonObj);
  }

  Future<Quiz> updateQuiz(int? id, int? idCategory, String? question) async {
    String url = ApiUrl.quiz + '/$id';
    var basicAuth = UserInfo.getAuth();
    var userId = await UserInfo.getId();
    var body = {
      "user_id": userId.toString(),
      "question": question,
      "category_id": idCategory.toString(),
      "is_private": '0'
    };
    var response = await Api().put(url, body, basicAuth);
    var jsonObj = json.decode(response.body);
    return Quiz.fromJson(jsonObj);
  }

  Future<Quiz> getQuizByUserAndCategory(int userId, int categoryId) async {
    String url = '${ApiUrl.quiz}/$userId/$categoryId';
    var basicAuth = UserInfo.getAuth();
    print(basicAuth);
    var response = await Api().get(url, basicAuth);
    var jsonObj = json.decode(response.body);
    print(jsonObj);
    return Quiz.fromJson(jsonObj);
  }

  Future<Quiz> deleteQuiz(int? id, int? idCategory, String? question) async {
    String url = '${ApiUrl.quiz}/$id';
    var userId = await UserInfo.getId();
    var basicAuth = UserInfo.getAuth();
    var body ={
      "user_id": userId.toString(),
      "question": question,
      "category_id": idCategory.toString(),
      "is_private": '1'
    };
    var response = await Api().put(url, body, basicAuth);
    var jsonObj = json.decode(response.body);
    return Quiz.fromJson(jsonObj);
  }

  Future<Quiz> getQuizByCategory(int categoryId) async {
    String url = '${ApiUrl.quiz}/category/$categoryId';
    var basicAuth = UserInfo.getAuth();
    var response = await Api().get(url, basicAuth);
    var jsonObj = json.decode(response.body);
    return Quiz.fromJson(jsonObj);
  }
}
