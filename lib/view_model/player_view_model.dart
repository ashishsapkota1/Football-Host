import 'package:flutter/cupertino.dart';
import 'package:football_host/data/database_Helper/database_helper.dart';
import 'package:football_host/data/model/player_model.dart';

class PlayerViewModel extends ChangeNotifier{
  final Map<int, List<Player>> _teamPlayers = {};
  
  List<Player> getPlayerList(int teamID){
    return _teamPlayers[teamID] ?? [];
  }
  
  void addPlayer(int teamId, Player player) async{
    Player newPlayer = await DbHelper.instance.insertPlayer(teamId, player);
    if(_teamPlayers.containsKey(teamId)){
      _teamPlayers[teamId]!.add(newPlayer);
    }else{
      _teamPlayers[teamId] = [newPlayer];
    }
    notifyListeners();
  }
  
}