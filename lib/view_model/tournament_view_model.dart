import 'package:flutter/cupertino.dart';
import 'package:football_host/model/player_model.dart';
import 'package:football_host/model/teams_model.dart';
import 'package:football_host/model/tournament_model.dart';
import 'package:hive/hive.dart';

class TournamentViewModel extends ChangeNotifier{
  final Box<Tournament> _box = Hive.box<Tournament>('tournaments');

  void createTournament(String name){
    final tournament = Tournament(tournamentName: name);
    _box.add(tournament);
    notifyListeners();
  }

  void addTeams(Tournament tournament, String name){
    final teamName = TeamName(teamName: name);
    tournament.teams.add(teamName);
    notifyListeners();
  }

  void addPlayers(TeamName teamName, String name , int jerseyNo, String position){
    final playerDetail = Player(playerName: name, jerseyNo: jerseyNo, position: position);
    teamName.playersName.add(playerDetail);
    notifyListeners();
  }

}