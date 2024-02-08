import 'package:flutter/cupertino.dart';
import 'package:football_host/data/database_Helper/database_helper.dart';
import 'package:football_host/data/model/player_model.dart';

class PlayerViewModel extends ChangeNotifier {
  late  List<Player> _playerList = [];

  List<Player> get playerList => _playerList;

  void addPlayer(
      int teamId, String playerName, String position, int jerseyNo) async {
    final players =
        Player(playerName: playerName, position: position, jerseyNo: jerseyNo);
    final int? playerId = await DbHelper.instance.insertPlayer(teamId, players);
    if (playerId != null) {
      final newPlayer = Player(
          id: playerId,
          playerName: playerName,
          position: position,
          jerseyNo: jerseyNo);
      _playerList.add(newPlayer);
      notifyListeners();
    } else {
      print('failed');
    }
  }

  Future<void> getPlayers(int teamId) async{
    final List<Player> players = await DbHelper.instance.getPlayers(teamId);
    _playerList = players;
    notifyListeners();
  }
}
