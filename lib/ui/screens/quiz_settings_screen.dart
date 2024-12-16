import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/blocs/category_cubit.dart';

class QuizSettingsScreen extends StatefulWidget {
  const QuizSettingsScreen({super.key});

  @override
  State<QuizSettingsScreen> createState() => _QuizSettingsScreenState();
}

class _QuizSettingsScreenState extends State<QuizSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Settings'),
      ),
      body: BlocBuilder<CategoryCubit, List<String>>(
          builder: (context, state) {
            return Expanded(child:
              ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state[index]),
                  );
                },
              )
            );
          }
      )
    );
  }
}
