import 'package:flutter/material.dart';
import '../data/database_Helper/database_helper.dart';
import '../data/model/tournament_model.dart';

class TournamentViewModel with ChangeNotifier {
  late  List<Tournament> _tournamentList = [];
  List<Tournament> get tournamentList => _tournamentList;



  Future<void> addTournament(String tournamentName, String pole) async {
    final tournament = Tournament(name: tournamentName, pole: pole);
    final int? tournamentId = await DbHelper.instance.insert(tournament);
    if(tournamentId != null){
      final newTournament = Tournament(id: tournamentId, name: tournamentName, pole: pole);
      _tournamentList.add(newTournament);
      notifyListeners();
    }else{
      print('failed to insert Tournament');
    }
  }

  Future<void> getTournaments() async {
    final List<Map<String, dynamic>>? tournaments = await DbHelper.instance.getTournaments();
    final tournament = tournaments!.map((data) => Tournament.fromMap(data)).toList();
    _tournamentList = tournament;
    notifyListeners();
  }

  Future<void> insertPolesToTournament(Tournament tournament, String poleFormation) async {
    Tournament newTournament = await DbHelper.instance.insertPoles(tournament, poleFormation);
    Tournament oldTournament = _tournamentList.firstWhere((obj) => obj.id == tournament.id);
    _tournamentList.remove(oldTournament);
    _tournamentList.add(newTournament);
    notifyListeners();
  }


}

