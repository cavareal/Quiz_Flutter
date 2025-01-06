import 'package:quizz/models/categories.dart';

class Settings {
  final Categories category;
  final int numberOfQuestions;
  final String difficulty;

  Settings({
    required this.category,
    required this.numberOfQuestions,
    required this.difficulty,
  });

  @override
  toString() {
    return 'Settings: { category: $category, numberOfQuestions: $numberOfQuestions, difficulty: $difficulty }';
  }
}