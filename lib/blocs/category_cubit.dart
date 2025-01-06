import 'package:quizz/repositories/quiz_category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<List<String>> {
  final QuizCategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super([]);

  Future<void> loadCategories() async {
    emit(await categoryRepository.fetchCategories());
  }
}