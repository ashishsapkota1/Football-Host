
import 'package:flutter/foundation.dart';
import 'package:football_host/data/model/match/match_model.dart';
import 'package:football_host/view_model/teamViewModel/team_view_model.dart';

class MatchViewModel extends ChangeNotifier {
  final List<Matches> _matches = [];
  TeamViewModel teamViewModel = TeamViewModel();

  List<Matches> get matches => _matches;

  void addMatch(int tournamentId, int team1Id, int team2Id, Matches match) {
    _matches.add(match);
    notifyListeners();
  }

}
