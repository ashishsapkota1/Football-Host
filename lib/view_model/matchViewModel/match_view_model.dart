
import 'package:flutter/foundation.dart';
import 'package:football_host/data/model/match/match_model.dart';

import '../../data/database_Helper/database_helper.dart';

class MatchViewModel extends ChangeNotifier {
  final Map<int, List<Matches>> _matches = {};
  List<Matches> getMatchesList(int tournamentId) {
    return _matches[tournamentId] ?? [];
  }

  Future<void> addMatches(int tournamentId, Matches matches) async{
    Matches newMatch = await DbHelper.instance.insertMatches(tournamentId, matches);
    if(_matches.containsKey(tournamentId)){
      _matches[tournamentId]!.add(newMatch);
    }else{
      _matches[tournamentId] = [newMatch];
    }
    notifyListeners();
  }
  final List<int> _scheduleId = [];
  List<int> get scheduleId => _scheduleId;
  bool matchAlreadyAdded( int scheduleId) {
    notifyListeners();
    return _scheduleId.contains(scheduleId);
  }


}
