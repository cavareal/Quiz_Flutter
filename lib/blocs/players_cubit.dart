import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/players.dart';

class PlayersCubit extends Cubit<List<Players>> {

  PlayersCubit() : super([]);

  void addPlayer(Players player) {
    state.add(player);
    emit(List.from(state));
  }

  void removePlayer(Players player) {
    state.remove(player);
    emit(List.from(state));
  }

  void updatePlayer(Players player) {
    state[state.indexWhere((element) => element.name == player.name)] = player;
    emit(List.from(state));
  }
}