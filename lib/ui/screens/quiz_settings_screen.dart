import 'package:flutter/material.dart';

class QuizSettingsScreen extends StatelessWidget {
  const QuizSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
            children: [
              const Text('Quiz Settings Screen'),
              ElevatedButton(
                  onPressed:() {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Go back to Home')
              )
            ]
        ),
      ),
    );
  }
}
