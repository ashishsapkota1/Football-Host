import 'package:flutter/foundation.dart';
import 'package:football_host/data/database_Helper/queries/player_queries.dart';
import 'package:football_host/data/model/player_model.dart';

class PlayerViewModel extends ChangeNotifier {
  late  List<Player> _playerList = [];

  List<Player> get playerList => _playerList;

  late  List<Player> _player2List = [];

  List<Player> get playerList2 => _player2List;

  void addPlayer(
      int teamId, String playerName, String position, int jerseyNo) async {
    final players =
        Player(playerName: playerName, position: position, jerseyNo: jerseyNo);
    final int? playerId = await PlayerQueries.insertPlayer(teamId, players);
    if (playerId != null) {
      final newPlayer = Player(
          id: playerId,
          playerName: playerName,
          position: position,
          jerseyNo: jerseyNo);
      _playerList.add(newPlayer);
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('failed');
      }
    }
  }

  Future<void> getPlayers(int teamId) async{
    final List<Player> players = await PlayerQueries.getPlayers(teamId);
    _playerList = players;
    notifyListeners();
  }

  Future<void> get2Players(int teamId) async{
    final List<Player> players = await PlayerQueries.getPlayers(teamId);
    _player2List = players;
    notifyListeners();
  }

  Future<String?> getPlayerName (int playerId)async{
    return await PlayerQueries.getPlayerName(playerId);
  }
}
