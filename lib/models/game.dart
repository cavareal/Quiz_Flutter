import 'package:flutter/cupertino.dart';

class Game {
  final String name;
  final IconData? logoIcon;
  final String? logoLetter;
  final AssetImage? logoImage;

  Game({required this.name, this.logoIcon, this.logoLetter, this.logoImage });
}