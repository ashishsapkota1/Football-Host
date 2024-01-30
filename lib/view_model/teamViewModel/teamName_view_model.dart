import 'package:flutter/cupertino.dart';
import 'package:football_host/data/database_Helper/database_helper.dart';
import 'package:football_host/data/model/match/match_schedule_model.dart';
import 'package:football_host/resources/utils/routes/routes_name.dart';

class TeamNameViewModel extends ChangeNotifier{

  late int? _selectedTeamId ;

  int? get selectedTeamId => _selectedTeamId;

  void setSelectedTeamId(int teamId) {
    _selectedTeamId = teamId;
    notifyListeners();
  }
  String _selectedTeam = '';

  String get selectedTeam => _selectedTeam;

  void setSelectedTeam(String teamName){
    _selectedTeam = teamName;
    notifyListeners();
  }

  String _selectedTeam2 = '';
  String get selectedTeam2 => _selectedTeam2;

  void setSelectedTeam2(String teamsName){
    _selectedTeam2 = teamsName;
    notifyListeners();
  }

  Future<String?> getTeamName(int teamId,) async{
   String? teamName = await DbHelper.instance.getTeamNameById(teamId);
   _selectedTeam2 = teamName!;
    notifyListeners();
    return null;

  }

}