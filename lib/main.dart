import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/blocs/players_cubit.dart';
import 'package:quizz/blocs/settings_cubit.dart';
import 'package:quizz/repositories/quiz_category_repository.dart';
import 'package:quizz/ui/screens/home_screen.dart';
import 'package:quizz/ui/screens/player_selection_screen.dart';
import 'package:quizz/ui/screens/quiz_screen.dart';
import 'package:quizz/ui/screens/quiz_settings_screen.dart';

import 'blocs/category_cubit.dart';

void main() {

  // Cubits instantiation
  final CategoryCubit categoryCubit = CategoryCubit(QuizCategoryRepository());
  final SettingsCubit settingsCubit = SettingsCubit();
  final PlayersCubit playersCubit = PlayersCubit();

  categoryCubit.loadCategories();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CategoryCubit>(create: (_) => categoryCubit),
        BlocProvider<SettingsCubit>(create: (_) => settingsCubit),
        BlocProvider<PlayersCubit>(create: (_) => playersCubit),
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
        '/quiz': (context) => const QuizScreen(),
      },
      initialRoute: '/home',
    );
  }
}