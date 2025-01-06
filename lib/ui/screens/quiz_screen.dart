import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/models/quiz_question.dart';
import 'package:quizz/repositories/quiz_question_repository.dart';
import 'package:quizz/ui/screens/quiz_end_screen.dart';
import 'package:flip_card/flip_card.dart';

import '../../blocs/settings_cubit.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;
  int _totalQuestions = 0;
  String? _selectedAnswer;
  List<String> _answers = [];
  late Future<List<QuizQuestion>> _questionsFuture;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  double get progress {
    return _totalQuestions == 0 ? 0.0 : _questionIndex / _totalQuestions;
  }
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

  void _validateAnswer(String correctAnswer) {

    if (_selectedAnswer == correctAnswer) {
      setState(() {
        _score++;
      });
    }
  }

  void _NextQuestion(int totalQuestions){
    _totalQuestions = totalQuestions;

    setState(() {
      _questionIndex++;
      _selectedAnswer = null;
      _answers = [];
    });

    cardKey.currentState?.toggleCard();

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
    return _quizQuestionRepository.fetchQuestion(context.read<SettingsCubit>().state);

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
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  // backgroundColor: Colors.grey[500],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                ), FlipCard(
                  // fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
                  direction: FlipDirection.HORIZONTAL,
                  side: CardSide.FRONT,
                  flipOnTouch: false,
                  key : cardKey,
                  front: Container(
                    margin: const EdgeInsets.only(top: 100.0),
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 0.8, // 80% de la largeur de l'écran
                    decoration: BoxDecoration(
                      color: const Color(0xFF3d485e),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            question.category,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            question.type.toString().split('.').last + " - " + question.difficulty.toString().split('.').last,
                            style: TextStyle(color: Colors.white.withOpacity(0.6)),
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
                          padding: const EdgeInsets.all(20),
                          itemCount: _answers.length,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedAnswer == _answers[index] ? Colors.pink : null,
                              ),
                              onPressed: () => _selectAnswer(_answers[index]),
                              child: Text(_answers[index]),
                            );
                          },
                        ),
                        Padding (
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _validateAnswer(question.correctAnswer);
                              cardKey.currentState?.toggleCard();
                            },
                            child: const Text('Validate'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  back: Container(
                    margin: const EdgeInsets.only(top: 100.0),
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 0.8, // 80% de la largeur de l'écran
                    decoration: BoxDecoration(
                      color: const Color(0xFF3d485e),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title:_selectedAnswer == question.correctAnswer ? const Text("Correct !", style: TextStyle(fontSize: 30)) : const Text("Wrong !", style: TextStyle(fontSize: 30)),
                          subtitle: Text(
                            question.category,
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
                          padding: const EdgeInsets.all(20),
                          itemCount: _answers.length,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:_answers[index] == question.correctAnswer ?
                                Colors.green : (_selectedAnswer == _answers[index] ? Colors.pink : null),// Default background when no answer is selected
                              ),
                              onPressed: ()  => () ,
                              child: Text(_answers[index]),
                            );
                          },
                        ),
                        Padding (
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF162132),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: IconButton(
                                  icon: const Icon(Icons.double_arrow, color: Colors.white),
                                  onPressed: () => _NextQuestion(snapshot.data!.length)
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child:Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}