import 'package:flutter/material.dart';

import '../../models/game.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});


  final List<Game> games = [
    Game(name: "General Quiz", logoLetter: "Q"),
    Game(name: "... En préparation ", logoIcon: Icons.engineering),
  ];

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
                      margin: const EdgeInsets.only(top:30, left:30, right:30),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        width: 25,
                        height: 110,
                        child:
                        Row(
                          children:[
                            if(games[index].logoIcon != null)...[
                              Icon(
                                games[index].logoIcon,
                                size: 70,
                                color: const Color(0xFFF26BFE),
                              )
                            ],
                            if(games[index].logoLetter != null)...[
                              const Text("Q", style :
                              TextStyle(
                                  fontSize: 60,
                                  color: Color(0xFFF26BFE),
                                  fontFamily: 'Limelight'
                              )
                              ),
                            ],
                            Expanded(
                              child: ListTile(
                                title: Text(games[index].name, style: const TextStyle(fontSize: 20)),
                                onTap: () {
                                  if(games[index].name == games[0].name){
                                    Navigator.of(context).pushNamed('/player-selection');
                                  }
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
