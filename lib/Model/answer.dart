class Answer {
  int? id;
  String? answer;
  int? quizId;

  Answer({this.id, this.answer, this.quizId});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: int.parse(json['id'].toString()),
      answer: json['answer_text'],
      quizId: int.parse(json['quiz_id'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer_text': answer,
      'quiz_id': quizId,
    };
  }
}

class AnswerResponse {
  bool? success;
  String? message;
  List<Answer>? data; // Ubah menjadi List<Answer>

  AnswerResponse({this.success, this.message, this.data});

  factory AnswerResponse.fromJson(Map<String, dynamic> json) {
    return AnswerResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Answer.fromJson(item))
          .toList(),
    );
  }
}
