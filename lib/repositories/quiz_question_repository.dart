import 'dart:convert';
import 'package:http/http.dart';
import 'package:quizz/models/settings.dart';

import '../models/quiz_question.dart';


class QuizQuestionRepository {

  //TODO: Implement the methods to interact with the QuizQuestion model
  Future<List<QuizQuestion>> fetchQuestion(Settings settings) async {

    // final String url = 'https://opentdb.com/api.php?amount=${settings.numberOfQuestions}&category=${settings.category.id}&difficulty=${settings.difficulty}';

    final Response response = await get(Uri.parse('https://opentdb.com/api.php?amount=10&category=22&difficulty=easy'));
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