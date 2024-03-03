class QuizQuestion {
  final String questionText;

  QuizQuestion(this.questionText);
}

class QuizSubject {
  final String name;
  final List<QuizQuestion> questions;

  QuizSubject(this.name, this.questions);
}

class QuizData {
  final bool success;
  final Map<String, List<String>> randomQuizQuestions;

  QuizData({required this.success, required this.randomQuizQuestions});

  factory QuizData.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>> questionsMap = {};
    json['random_quiz_questions'].forEach((key, value) {
      List<String> questions = [];
      for (var question in value) {
        questions.add(question);
      }
      questionsMap[key] = questions;
    });

    return QuizData(
      success: json['success'],
      randomQuizQuestions: questionsMap,
    );
  }
}
