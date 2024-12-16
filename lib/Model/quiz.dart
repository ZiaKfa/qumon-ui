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

class CreateQuizResponse {
  bool? success;
  String? message;
  CreateQuiz? data;

  CreateQuizResponse({this.success, this.message, this.data});

  factory CreateQuizResponse.fromJson(Map<String, dynamic> json) {
    return CreateQuizResponse(
      success: json['success'],
      message: json['message'],
      data: CreateQuiz.fromJson(json['data']),
    );
  }
}

class CreateQuiz {
  int? id;
  String? question;
  int? user_id;
  int? category_id;
  int? is_private;

  CreateQuiz(
      {this.id,
      this.question,
      this.user_id,
      this.category_id,
      this.is_private});

  factory CreateQuiz.fromJson(Map<String, dynamic> json) {
    return CreateQuiz(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      question: json['question'],
      user_id: json['user_id'] != null
          ? int.parse(json['user_id'].toString())
          : null,
      category_id: json['category_id'] != null
          ? int.parse(json['category_id'].toString())
          : null,
      is_private: json['is_private'] != null
          ? int.parse(json['is_private'].toString())
          : null,
    );
  }
}
