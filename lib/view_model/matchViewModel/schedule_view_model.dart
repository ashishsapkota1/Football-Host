import 'package:flutter/cupertino.dart';
import 'package:football_host/data/database_Helper/database_helper.dart';
import '../../data/model/match/match_schedule_model.dart';


class ScheduleViewModel extends ChangeNotifier{
  final Map<int, List<MatchSchedule>> _schedule = {};
 List<MatchSchedule> getScheduleList(int tournamentId) {
   return _schedule[tournamentId] ?? [];
 }

void addSchedule(int tournamentId, int team1Id, int team2Id,String team1Name, String team2Name, MatchSchedule schedule) async{
  MatchSchedule newSchedule = await DbHelper.instance.insertSchedule(tournamentId, team1Id, team2Id,team1Name,team2Name, schedule);
  if(_schedule.containsKey(tournamentId)){
    _schedule[tournamentId]!.add(newSchedule);
  }else{
    _schedule[tournamentId] = [newSchedule];
  }
  notifyListeners();
}

}
