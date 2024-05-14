import 'package:flutter/foundation.dart';
import 'package:football_host/data/database_Helper/database_helper.dart';
import 'package:football_host/data/database_Helper/queries/team_queries.dart';

import '../../data/model/team_model.dart';

class TeamViewModel extends ChangeNotifier {
  late List<Team> _tournamentTeams = [];

  List<Team> get tournamentTeams => _tournamentTeams;

  Future<void> addTeam(int tournamentId, String teamName) async {
    final team = Team(teamName: teamName);
    final int? teamId = await TeamQueries.insertTeams(tournamentId, team);
    if (teamId != null) {
      final newTeam = Team(id: teamId, teamName: teamName);
      _tournamentTeams.add(newTeam);
      notifyListeners();
    } else {
      print('failed');
    }
  }

  Future<void> getTournamentTeams(int tournamentId) async {
    final List<Team> teams = await TeamQueries.getTeams(tournamentId);
    _tournamentTeams = teams;
    notifyListeners();
  }

  Future<void> deleteTeam(int teamId) async {
    try {
      await TeamQueries.deleteTeam(teamId);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }


}
