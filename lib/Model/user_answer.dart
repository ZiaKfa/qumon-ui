class UserAnswer {
  int? user_id;
  int? quiz_id;
  String? answer_text;
  bool? is_correct;

  UserAnswer({this.user_id, this.quiz_id, this.answer_text, this.is_correct});

  UserAnswer.fromJson(Map<String, dynamic> json) {
    user_id = int.tryParse(json['user_id'].toString());
    quiz_id = int.tryParse(json['quiz_id'].toString());
    answer_text = json['text'];
    is_correct = bool.tryParse(json['is_correct'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user_id;
    data['quiz_id'] = quiz_id;
    data['text'] = answer_text;
    data['is_correct'] = is_correct;
    return data;
  }
}

class UserAnswerResponse {
  bool? success;
  String? message;
  UserAnswer? data;

  UserAnswerResponse({this.success, this.message, this.data});

  UserAnswerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UserAnswer.fromJson(json['data']) : null;
  }
}
