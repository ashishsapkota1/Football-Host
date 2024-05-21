import 'package:flutter/foundation.dart';
import 'package:football_host/data/database_Helper/queries/match_queries.dart';
import 'package:football_host/data/model/match/goal_scored.dart';

class GoalScorerViewModel extends ChangeNotifier {
  late  List<GoalScorer> _goalScorer = [];
  List<GoalScorer> get goalScorer => _goalScorer;

  Future<void> addGoalScorer(
      int matchId, int teamId, int scorerId, int goalTime) async {
    final goalScorer = GoalScorer(
        matchId: matchId,
        teamId: teamId,
        scorerId: scorerId,
        goalTime: goalTime);
    final int? goalScorerId = await MatchQueries.addGoalScorer(goalScorer);

    if (goalScorerId != null) {
      final newGoalScorer = GoalScorer(
          id: goalScorerId,
          matchId: matchId,
          teamId: teamId,
          scorerId: scorerId,
          goalTime: goalTime);
      _goalScorer.add(newGoalScorer);
      notifyListeners();
    } else {
     _goalScorer = [];
    }
  }


}
