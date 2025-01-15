import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/blocs/players_cubit.dart';

import '../../models/players.dart';

class PlayerSelectionScreen extends StatefulWidget {
  const PlayerSelectionScreen({super.key});

  @override
  State<PlayerSelectionScreen> createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Selection'),
      ),
      body: BlocBuilder<PlayersCubit, List<Players>>(builder: (context, state) {
        return Column(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3d485e),
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Row(children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onFieldSubmitted: (value) {submitPlayer(context);},
                          decoration: InputDecoration(
                            fillColor: const Color(0xFF3d485e),
                            labelText: 'Add a player',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          controller: _textFieldController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        )
                      ),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.white),
                          iconColor: WidgetStateProperty.all(const Color(0xFF3d485e)),
                        ),
                        onPressed: () {
                           submitPlayer(context);
                        },
                        icon: const Icon(Icons.add)
                      )
                    ]),
                  )
                ),
                const Divider(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    child: ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  state[index].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF3d485e),
                                  )
                                )
                              ),
                              IconButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(Colors.pinkAccent),
                                ),
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  context.read<PlayersCubit>().removePlayer(state[index]);
                                }
                              )
                            ]
                          )
                        );
                      }
                    )
                  )
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20), // Set the desired margin
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    shadowColor: WidgetStateProperty.all(Colors.black),
                    backgroundColor: WidgetStateProperty.all(Colors.pinkAccent),
                  ),
                  onPressed: () {
                    if (state.length < 2) {
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
                            ]);
                        }
                      );
                      return;
                    }
                    Navigator.of(context).pushNamed('/quiz-settings');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      'Start Quiz',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )
                    )
                  )
                )
              ],
            )
          )
        ]);
      })
    );
  }

  void submitPlayer(BuildContext context) {
    if (_formKey.currentState!.validate()) {
     context.read<PlayersCubit>().addPlayer(
         Players(name: _textFieldController.text)
     );
      _textFieldController.clear();
    }
  }
}
