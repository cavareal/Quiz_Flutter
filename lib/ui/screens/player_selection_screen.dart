import 'package:flutter/material.dart';

class PlayerSelectionScreen extends StatefulWidget {
  const PlayerSelectionScreen({super.key});

  @override
  State<PlayerSelectionScreen> createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _playerNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Selection'),
      ),
      body: Column(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Row(children: [
                  Expanded(
                    child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Player Name',
                      fillColor: Colors.red,
                      filled: true,
                    ),
                    controller: _textFieldController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  )),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _playerNames.add(_textFieldController.text);
                          _textFieldController.clear();
                        });
                      }
                    },
                    icon: const Icon(Icons.add))
                ]),
              ),
              const Divider(),
              Expanded(
                child: ListView.separated(
                itemCount: _playerNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.red,
                    title: Text(_playerNames[index]),
                    trailing: IconButton(
                      style: ButtonStyle(
                        backgroundColor:
                          WidgetStateProperty.all(Colors.blue),
                      ),
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          _playerNames.removeAt(index);
                        });
                      }
                    )
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ))
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Go back to Home')),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
              ),
              onPressed: () {
                if (_playerNames.length < 2) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Not enough players'),
                        content: const Text('You need at least 2 players to start the quiz'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK')
                          )
                        ]
                      );
                    }
                  );
                  return;
                }
                Navigator.of(context).pushNamed('/quiz-settings', arguments: _playerNames);
              },
              child: const Text('Start Quiz'))
          ],
        )
      ]),
    );
  }
}
