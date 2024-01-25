import 'package:flutter/cupertino.dart';

import '../../data/database_Helper/database_helper.dart';
import '../../data/model/match/match_schedule_model.dart';
import '../../data/model/team_model.dart';


class ScheduleViewModel extends ChangeNotifier{
  final List<MatchSchedule> _schedule = [];

 List<MatchSchedule> get schedule => _schedule;

 Future<void> generateAndInsertSchedule(int tournamentId) async {
   List<MatchSchedule> newSchedule = await generateTournamentSchedule(tournamentId);

   _schedule.addAll(newSchedule);
   notifyListeners();
 }

 Future<List<MatchSchedule>> generateTournamentSchedule(int tournamentId) async {
   var dbClient = await DbHelper().db;

   List<Team> teams = await _getTournamentTeams(tournamentId);

   teams.shuffle();

   if (teams.length % 2 != 0) {
     teams.add(Team(id: -1, teamName: 'Bye', tournamentId: tournamentId));
   }


   for (int i = 0; i < teams.length - 1; i++) {
     for (int j = i + 1; j < teams.length; j++) {
       MatchSchedule matchSchedule = MatchSchedule(
         tournamentId: tournamentId,
         team1Id: teams[i].id!,
         team2Id: teams[j].id!,
       );

       await dbClient?.insert('Schedule', matchSchedule.toMap(tournamentId, teams[i].id!, teams[j].id!));

       _schedule.add(matchSchedule);
     }
   }

   return _schedule;
 }

 // Function to get tournament teams
 Future<List<Team>> _getTournamentTeams(int tournamentId) async {
   return await DbHelper().getTournamentTeams(tournamentId);
 }

 // Function to insert a match into the database
 Future<void> insertSchedule(MatchSchedule schedule) async {
   var dbClient = await DbHelper().db;
   await dbClient?.insert('Schedule', schedule.toMap(schedule.tournamentId!, schedule.team1Id!, schedule.team2Id!));
 }
}