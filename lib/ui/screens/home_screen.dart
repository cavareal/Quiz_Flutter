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
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                child: Center(
                  child: Column(
                    children: [
                      const Expanded(
                        child: ClipOval(
                          child: Image(
                            image: AssetImage('lib/assets/logo.png'),
                          ),
                        )
                      ),
                      Container(
                        margin:  const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Kalsarikännit',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF26BFE),
                              fontFamily: 'MajorMono'
                          ),
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
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        width: 25,
                        child:
                        Row(
                          children:[
                            const Text("Q", style :
                              TextStyle(
                                fontSize: 60,
                                color: Color(0xFFF26BFE),
                                fontFamily: 'Limelight'
                              )
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(games[index], style: const TextStyle(fontSize: 20)),
                                onTap: () {
                                  Navigator.of(context).pushNamed('/player-selection');
                                },
                              ),
                            ),
                          ]
                        ),
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
