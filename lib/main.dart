import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/repositories/quiz_category_repository.dart';
import 'package:quizz/ui/screens/home_screen.dart';
import 'package:quizz/ui/screens/player_selection_screen.dart';
import 'package:quizz/ui/screens/quiz_settings_screen.dart';

import 'blocs/category_cubit.dart';

void main() {

  // Cubits instantiation
  final CategoryCubit categoryCubit = CategoryCubit(QuizCategoryRepository());

  categoryCubit.loadCategories();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CategoryCubit>(create: (_) => categoryCubit)
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/player-selection': (context) => const PlayerSelectionScreen(),
        '/quiz-settings': (context) => const QuizSettingsScreen(),
      },
      initialRoute: '/home',
    );
  }
}