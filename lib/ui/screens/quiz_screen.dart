import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz/models/quiz_question.dart';
import 'package:quizz/repositories/quiz_question_repository.dart';
import 'package:quizz/ui/screens/quiz_end_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  List<String> _answers = [];
  late Future<List<QuizQuestion>> _questionsFuture;

  @override
  void initState() {
    super.initState();
    _questionsFuture = getQuestions();
  }

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _validateAnswer(String correctAnswer, int totalQuestions) {

    if (_selectedAnswer == correctAnswer) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      _selectedAnswer = null;
      _answers = [];
      _questionIndex++;
    });

    if (_questionIndex >= totalQuestions) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizEndScreen(
            score: _score,
            totalQuestions: totalQuestions,
          ),
        ),
      );
    }
  }


  final QuizQuestionRepository _quizQuestionRepository = QuizQuestionRepository();

  Future<List<QuizQuestion>> getQuestions() {
    return _quizQuestionRepository.fetchQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: FutureBuilder<List<QuizQuestion>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final question = snapshot.data![_questionIndex];
            if (_answers.isEmpty) {
              _answers = [question.correctAnswer, ...question.incorrectAnswers]..shuffle();
            }
            return Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          question.category,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          question.type.toString().split('.').last + " - " + question.difficulty.toString().split('.').last,
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          question.question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(15),
                        itemCount: _answers.length,
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedAnswer == _answers[index] ? Colors.blue : Colors.grey,
                            ),
                            onPressed: () => _selectAnswer(_answers[index]),
                            child: Text(_answers[index]),
                          );
                        },
                      ),
                      Padding (
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: ElevatedButton(
                          onPressed: () => _validateAnswer(question.correctAnswer, snapshot.data!.length),
                          child: const Text('Validate'),
                        ),
                      ),

                    ],
                  ),
                ),
                Text(_score.toString())
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}