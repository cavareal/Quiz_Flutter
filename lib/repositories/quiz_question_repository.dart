import 'dart:convert';
import 'package:http/http.dart';
import 'package:quizz/models/settings.dart';

import '../models/quiz_question.dart';


class QuizQuestionRepository {

  Future<List<QuizQuestion>> fetchQuestion(Settings settings) async {
    final int amount = settings.numberOfQuestions;
    final int category = settings.category.id;
    final String difficulty = settings.difficulty;

    final url = 'https://opentdb.com/api.php?amount=$amount&category=$category&difficulty=$difficulty';

    final Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<QuizQuestion> questions = [];

      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("results")) {
        final List<dynamic> results = json['results'];

        for (Map<String, dynamic> result in results) {
          final QuizQuestion question = QuizQuestion.fromJson(result);
          questions.add(question);
        }
      }
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }
}