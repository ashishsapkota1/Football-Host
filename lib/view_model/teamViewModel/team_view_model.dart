import 'package:flutter/cupertino.dart';
import 'package:football_host/data/database_Helper/database_helper.dart';

import '../../data/model/team_model.dart';


class TeamViewModel extends ChangeNotifier{

  final Map<int, List<Team>> _tournamentTeams = {};
  List<Team> getTournamentTeams(int tournamentId){
    return _tournamentTeams[tournamentId] ?? [];
  }
  void addTeam(int tournamentId, Team teams) async{
    Team newTeam = await DbHelper().insertTeams(tournamentId, teams);
    if(_tournamentTeams.containsKey(tournamentId)){
      _tournamentTeams[tournamentId]!.add(newTeam);
    }else{
      _tournamentTeams[tournamentId] = [newTeam];
    }
    notifyListeners();
  }


}