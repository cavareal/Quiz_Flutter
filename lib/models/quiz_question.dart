import 'package:html_unescape/html_unescape.dart';


class QuizQuestion {
  QuestionType type;
  QuestionDifficulty difficulty;
  String category;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  QuizQuestion({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    var unescape = HtmlUnescape();
    return QuizQuestion(
      type: QuestionType.values.firstWhere((e) => e.toString().split('.').last == json['type']),
      difficulty: QuestionDifficulty.values.firstWhere((e) => e.toString().split('.').last == json['difficulty']),
      category: unescape.convert(json['category']),
      question: unescape.convert(json['question']),
      correctAnswer: unescape.convert(json['correct_answer']),
      incorrectAnswers: List<String>.from(json['incorrect_answers'].map((answer) => unescape.convert(answer))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString().split('.').last,
      'difficulty': difficulty,
      'category': category,
      'question': question,
      'correct_answer': correctAnswer,
      'incorrect_answers': incorrectAnswers,
    };
  }
}

enum QuestionType {
  boolean,
  multiple
}

enum QuestionDifficulty {
  easy,
  medium,
  hard
}