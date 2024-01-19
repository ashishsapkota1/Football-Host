import 'package:flutter/cupertino.dart';

class TournamentNameViewModel extends ChangeNotifier{


  String _selectedTournamentId = '';

  String get selectedTournamentId => _selectedTournamentId;

  void setSelectedTournamentId(String tournamentId) {
    _selectedTournamentId = tournamentId;
    notifyListeners();
  }
  String _selectedTournament = '';

  String get selectedTournament => _selectedTournament;

  void setSelectedTournament(String tournamentName){
    _selectedTournament = tournamentName;
    notifyListeners();
  }


}