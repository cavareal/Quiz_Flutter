import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/blocs/category_cubit.dart';
import 'package:quizz/blocs/settings_cubit.dart';
import 'package:quizz/models/categories.dart';
import 'package:quizz/ui/components/dropdown_selector.dart';

import '../../models/settings.dart';

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
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF3d485e),
              border: Border.all(
                color: Colors.white,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Form(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // CATEGORY
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF162132),
                        border: Border.all(
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Category:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            BlocBuilder<CategoryCubit, List<Categories>>(
                              builder: (context, state) {
                                return DropdownSelector(
                                  items: state.map((category) => category.name).toList(),
                                  onChanged: (String value) {
                                    state.where((category) => category.name == value).forEach((category) {
                                      context.read<SettingsCubit>().setCategory(category);
                                    });
                                  }
                                );
                              }
                            ),
                          ],
                        ),
                      )
                    ),

                    // DIFFICULTY
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF162132),
                        border: Border.all(
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Difficulty:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            DropdownSelector(
                              items: difficulties,
                              onChanged: (String? value) {
                                context.read<SettingsCubit>().setDifficulty(value!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // NUMBER OF QUESTIONS
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF162132),
                        border: Border.all(
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Number of questions:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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
                          Text(
                            state.numberOfQuestions.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),

                    // START QUIZ BUTTON
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(const Color(0xFFF26BFE)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/quiz');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: const Text(
                          'Start Quiz',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                      ),
                    )
                  ],
                )
              )
            )
          );
        }
      )
    );
  }
}