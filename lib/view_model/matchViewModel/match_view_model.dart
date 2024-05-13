import 'package:flutter/foundation.dart';
import 'package:football_host/data/model/match/match_model.dart';

import '../../data/database_Helper/database_helper.dart';

class MatchViewModel extends ChangeNotifier {
  late List<Matches> _matches = [];

  List<Matches> get matches => _matches;

  late bool _isFirstHalf = false;

  bool get isFirstHalf => _isFirstHalf;

  late bool _isSecondHalf = false;

  bool get isSecondHalf => _isSecondHalf;

  late bool _hasStarted = false;

  bool get hasStarted => _hasStarted;

  late int _matchTime = 0;

  int get matchTime => _matchTime;

  Future<void> addMatches(int tournamentId, Matches matches) async {
    final int? matchId =
        await DbHelper.instance.insertMatches(tournamentId, matches);
    if (matchId != null) {
      Matches matches = Matches(id: matchId);
      _matches.add(matches);
      notifyListeners();
    } else {
      print('failed');
    }
  }

  Future<void> addMatchTime(int matchId, int matchTime) async {
    await DbHelper.instance.insertMatchTime(matchId, matchTime);
    _matchTime = matchTime;
    notifyListeners();
  }

  Future<void> getMatches(int tournamentId) async {
    List<Matches> match = await DbHelper.instance.getMatches(tournamentId);
    _matches = match;
    notifyListeners();
  }

  bool matchAlreadyAdded(int scheduleId) {
    for (Matches matches in _matches) {
      if (matches.scheduleId == scheduleId) {
        return true;
      }
    }
    return false;
  }

  Future<void> firstHalf(int matchId, bool firstHalf) async {
    await DbHelper.instance.update1stHalf(matchId, firstHalf);
    _isFirstHalf = firstHalf;
    notifyListeners();
  }

  Future<void> secondHalf(int matchId, bool secondHalf) async {
    await DbHelper.instance.update2ndHalf(matchId, secondHalf);
    _isSecondHalf = secondHalf;
    notifyListeners();
  }

  Future<void> matchStarted(int matchId, bool hasStarted)async {
    await DbHelper.instance.updateHasStarted(matchId, hasStarted);
    _hasStarted = hasStarted;
    notifyListeners();
  }

  Future<void> getHasStarted(int matchId)async{
    final result = await DbHelper.instance.getHasStarted(matchId);
    _hasStarted = result != 0;
    notifyListeners();
  }

  Future<void> getFirstHalf(int matchId)async{
    final result = await DbHelper.instance.get1stHalf(matchId);
    _isFirstHalf = result != 0;
    notifyListeners();
  }

  Future<void> getSecondHalf(int matchId)async{
    final result = await DbHelper.instance.get2ndHalf(matchId);
    _isSecondHalf = result != 0;
    notifyListeners();
  }


}
