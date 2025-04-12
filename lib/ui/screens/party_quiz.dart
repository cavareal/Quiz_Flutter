import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/database_helper.dart';
import '../../models/party_question.dart';

class QuestionListPage extends StatefulWidget {
  @override
  _QuestionListPageState createState() => _QuestionListPageState();
}

class _QuestionListPageState extends State<QuestionListPage> {
  List<PartyQuestion> _questions = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questions = await DatabaseHelper().getQuestions();
    setState(() {
      _questions = questions;
    });
  }

  Future<void> _addQuestion() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    await DatabaseHelper().insertQuestion(PartyQuestion(text: text));
    _controller.clear();
    _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Je n’ai jamais...')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Nouvelle question'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addQuestion,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_questions[index].text),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}