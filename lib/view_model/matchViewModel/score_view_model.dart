import 'package:flutter/foundation.dart';
import 'package:football_host/data/database_Helper/database_helper.dart';

class ScoreViewModel extends ChangeNotifier {
  late int _team1Score = 0 ;

  int get team1Score => _team1Score;

  late int _team2Score = 0 ;

  int get team2Score => _team2Score;

  Future<void> addTeam1Goal(int matchId, int goalNumber) async{
    await DbHelper.instance.addTeam1Goal(matchId, goalNumber+1);
    _team1Score = goalNumber +1;
    notifyListeners();
  }

  Future<void> addTeam2Goal(int matchId, int goalNumber) async{
    await DbHelper.instance.addTeam2Goal(matchId, goalNumber+1);
    _team2Score = goalNumber +1;
    notifyListeners();
  }

}