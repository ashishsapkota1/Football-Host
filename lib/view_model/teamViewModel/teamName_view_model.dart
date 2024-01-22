import 'package:flutter/cupertino.dart';

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

}