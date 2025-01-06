import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/blocs/category_cubit.dart';
import 'package:quizz/blocs/settings_cubit.dart';
import 'package:quizz/ui/components/dropdown_selector.dart';

import '../../models/settings.dart';

// TODO: Get the list of categories from a state
const List<String> difficulties = ["easy", "medium", "hard"];

class QuizSettingsScreen extends StatefulWidget {
  const QuizSettingsScreen({super.key});

  @override
  State<QuizSettingsScreen> createState() => _QuizSettingsScreenState();
}

class _QuizSettingsScreenState extends State<QuizSettingsScreen> {

  final int _maxNumberOfQuestions = 50;
  final int _minNumberOfQuestions = 10;
  final int _stepNumberOfQuestions = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Settings'),
      ),
      body: BlocBuilder<SettingsCubit, Settings>(
        builder: (context, state) {
          return Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // CATEGORY
                const Text('Choose a category:'),
                BlocBuilder<CategoryCubit, List<String>>(
                  builder: (context, state) {
                    return DropdownSelector(
                      items: state,
                      onChanged: (String value) {
                        context.read<SettingsCubit>().setCategory(value);
                      }
                    );
                  }
                ),

                // DIFFICULTY
                const Text('Choose a difficulty:'),
                DropdownSelector(
                  items: difficulties,
                  onChanged: (String? value) {
                    context.read<SettingsCubit>().setDifficulty(value!);
                  },
                ),

                // NUMBER OF QUESTIONS
                const Text('Select a number of questions:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_minNumberOfQuestions.toString()),
                    Slider(
                      value: state.numberOfQuestions.toDouble(),
                      min: _minNumberOfQuestions.toDouble(),
                      max: _maxNumberOfQuestions.toDouble(),
                      divisions: ((_maxNumberOfQuestions - _minNumberOfQuestions) / _stepNumberOfQuestions).round(),
                      label: state.numberOfQuestions.round().toString(),
                      onChanged: (double value) {
                        context.read<SettingsCubit>().setNumberOfQuestions(value.round());
                      }
                    ),
                    Text(_maxNumberOfQuestions.toString())
                  ]
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/quiz');
                  },
                  child: const Text('Start Quiz'),
                )
              ],
            )
          );
        }
      )
    );
  }
}