import 'package:flutter/cupertino.dart';

import '../data/model/team_model.dart';


class TeamViewModel extends ChangeNotifier{

  List<Team> _teams = [];

  List<Team> get teams => _teams;

  void addTeam(Team team){
    _teams.add(team);
    notifyListeners();
  }
}