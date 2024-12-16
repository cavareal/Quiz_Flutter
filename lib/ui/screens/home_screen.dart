import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
            children: [
              const Text('Home Screen'),
              ElevatedButton(
                  onPressed:() {
                    Navigator.of(context).pushNamed('/player-selection');
                  },
                  child: const Text('Go to Quiz Settings')
              )
            ]
        ),
      ),
    );
  }
}
