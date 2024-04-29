
import 'package:flutter/foundation.dart';
import 'package:football_host/data/model/match/match_model.dart';

import '../../data/database_Helper/database_helper.dart';

class MatchViewModel extends ChangeNotifier {
  late List<Matches> _matches = [];
  List<Matches> get matches => _matches;

   late int _matchTime = 0 ;
  int get matchTime => _matchTime;

 Future<void> addMatches(int tournamentId, Matches matches) async{
   final int? matchId = await DbHelper.instance.insertMatches(tournamentId, matches);
   if(matchId != null){
     Matches matches = Matches(id: matchId);
     _matches.add(matches);
     notifyListeners();
   }else{
     print('failed');
   }
 }

  Future<void> addMatchTime(int matchId, int matchTime) async{
    await DbHelper.instance.insertMatchTime(matchId, matchTime);
    _matchTime = matchTime;
      notifyListeners();

  }

 Future<void> getMatches(int tournamentId) async{
   List<Matches> match = await DbHelper.instance.getMatches(tournamentId);
   _matches = match;
   notifyListeners();
 }

 bool matchAlreadyAdded(int scheduleId) {
   for(Matches matches in _matches) {
     if (matches.scheduleId == scheduleId) {
       return true;
     }
   }
   return false;
 }

}
