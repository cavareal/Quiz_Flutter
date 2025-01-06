import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> games = ["General Quiz"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201a20),
      body: Center(
        child: Column(

          children: [
            const Text('Home Screen'),

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(30),
                child: const Center(
                  child: Column(
                    children: [
                      Expanded(child: Center(child: ClipOval(
                        child: Image(
                          image: AssetImage('lib/assets/logo_zoom.png'),
                        ),
                      ))),
                      Text(
                        'Kalsarikännit',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF26BFE),
                          fontFamily: 'MajorMono'
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return(
                    Card(
                      margin: const EdgeInsets.all(30),
                      child: ListTile(
                        title: Text(games[index]),
                        onTap: () {
                          Navigator.of(context).pushNamed('/player-selection');
                        },
                      ),
                    )
                  );
                },
              )
            )
          ]
        ),
      ),
    );
  }
}
