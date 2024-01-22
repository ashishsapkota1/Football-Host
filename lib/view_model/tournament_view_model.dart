import 'package:flutter/material.dart';
import '../data/database_Helper/database_helper.dart';
import '../data/model/tournament_model.dart';

class TournamentViewModel with ChangeNotifier {
  final List<Tournament> _tournamentList = [];

  List<Tournament> get tournamentList => _tournamentList;

  Future<void> addTournament(Tournament tournament) async {
    Tournament newTournament =await DbHelper().insert(tournament);
    _tournamentList.add(newTournament);
    notifyListeners();
  }


}

