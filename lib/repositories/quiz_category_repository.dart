import 'dart:convert';
import 'package:http/http.dart';
import 'package:quizz/models/categories.dart';

class QuizCategoryRepository {

  Future<List<Categories>> fetchCategories() async {
    final Response response = await get(Uri.parse('https://opentdb.com/api_category.php'));

    if (response.statusCode == 200) {
      final List<Categories> categories = [];

      final Map<String, dynamic> json = jsonDecode(response.body);

      if (json.containsKey("trivia_categories")) {
        // Retrieve the trivia_categories list
        final List<dynamic> triviaCategories = json["trivia_categories"];

        // Transform each trivia_category into a String object
        for (Map<String, dynamic> triviaCategory in triviaCategories) {
          categories.add(Categories(name: triviaCategory["name"], id: triviaCategory["id"]));
        }
      }
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}