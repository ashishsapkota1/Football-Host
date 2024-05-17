import 'package:flutter/cupertino.dart';
import 'package:football_host/data/database_Helper/queries/team_queries.dart';


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


  Future<String?> getTeamName(int teamId) async{
   String? teamName = await TeamQueries.getTeamNameById(teamId);
   _selectedTeam2 = teamName!;
    notifyListeners();
    return null;

  }

}