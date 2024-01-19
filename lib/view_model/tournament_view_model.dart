import 'package:flutter/cupertino.dart';

import '../data/model/tournament_model.dart';

class TournamentViewModel extends ChangeNotifier{
  List<Tournament> _tournaments = [];
  List<Tournament> get tournaments => _tournaments;

  void addTournament(Tournament tournament){
    _tournaments.add(tournament);
    notifyListeners();
  }
}


