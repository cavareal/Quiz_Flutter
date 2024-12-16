

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizEndScreen extends StatelessWidget {

  final int score;
  final int totalQuestions;

  QuizEndScreen({
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz End'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Score: $score / $totalQuestions',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Restart Quiz'),
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
