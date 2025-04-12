import 'package:bloc/bloc.dart';

import '../models/game.dart';

class GameCubit extends Cubit<Game> {
  GameCubit() : super(Game(name:"null"));

  void setLastPlayedGame(Game game) {
    emit(game);
  }

  Game getLastPlayedGame() {
    return state;
  }
}
