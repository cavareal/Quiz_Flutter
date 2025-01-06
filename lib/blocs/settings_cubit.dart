import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/settings.dart';

class SettingsCubit extends Cubit<Settings> {
  SettingsCubit() : super(
      Settings(
          category: 'General Knowledge',
          numberOfQuestions: 15,
          difficulty: 'easy'
      )
  );

  void setCategory(String category) {
    emit(
        Settings(
            category: category,
            numberOfQuestions: state.numberOfQuestions,
            difficulty: state.difficulty
        )
    );
  }

  void setNumberOfQuestions(int numberOfQuestions) {
    emit(
        Settings(
            category: state.category,
            numberOfQuestions: numberOfQuestions,
            difficulty: state.difficulty
        )
    );
  }

  void setDifficulty(String difficulty) {
    emit(
        Settings(
            category: state.category,
            numberOfQuestions: state.numberOfQuestions,
            difficulty: difficulty
        )
    );
  }
}