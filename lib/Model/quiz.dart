class Quiz {
  bool? success;
  String? message;
  List<QuizData>? data;

  Quiz({this.success, this.message, this.data});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => QuizData.fromJson(item))
          .toList(),
    );
  }
}

class QuizData {
  int? id;
  String? question;
  String? user;
  String? answer;
  String? category;

  QuizData({this.id, this.question, this.user, this.answer, this.category});

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      id: json['id'],
      question: json['question'],
      user: json['user'],
      answer: json['answer'],
      category: json['category'],
    );
  }

  @override
  String toString() {
    return '{id: $id, question: $question, user: $user, answer: $answer, category: $category}';
  }
}
