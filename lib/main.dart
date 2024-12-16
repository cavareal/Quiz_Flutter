import 'package:flutter/material.dart';
import 'package:quizz/ui/screens/home_screen.dart';
import 'package:quizz/ui/screens/quiz_settings_screen.dart';

void main() {
  runApp(const MyApp());
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
        '/quiz-settings': (context) => const QuizSettingsScreen(),
      },
      initialRoute: '/home',
    );
  }
}