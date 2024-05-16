import 'package:flutter/foundation.dart';
import 'package:football_host/data/database_Helper/queries/match_queries.dart';

class ScoreViewModel extends ChangeNotifier {
  late int _team1Score = 0 ;

  int get team1Score => _team1Score;

  late int _team2Score = 0 ;

  int get team2Score => _team2Score;

  Future<void> addTeam1Goal(int matchId, int goalNumber) async{
    await MatchQueries.addTeam1Goal(matchId, goalNumber);
    _team1Score = goalNumber;
    notifyListeners();
  }

  Future<void> addTeam2Goal(int matchId, int goalNumber) async{
    await MatchQueries.addTeam2Goal(matchId, goalNumber);
    _team2Score = goalNumber;
    notifyListeners();
  }

  Future<void> getTeam1Score (int matchId) async{
    int? score = await MatchQueries.getTeam1Score(matchId);
    if(score != null) {
      _team1Score = score;
    }else{
      _team1Score = 0;
    }
    notifyListeners();
  }

  Future<void> getTeam2Score (int matchId) async{
    int? score = await MatchQueries.getTeam2Score(matchId);
    if(score != null) {
      _team2Score = score;
    }else{
      _team2Score = 0;
    }
    notifyListeners();
  }

}