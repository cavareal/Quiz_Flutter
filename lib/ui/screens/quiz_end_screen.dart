

import 'package:flutter/material.dart';

class QuizEndScreen extends StatelessWidget {

  final int score;
  final int totalQuestions;

  const QuizEndScreen({super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz End'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Score: $score / $totalQuestions',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Restart Quiz'),
              onPressed:(){
                Navigator.of(context).pushNamed('/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
