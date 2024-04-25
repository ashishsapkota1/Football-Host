import 'package:flutter/cupertino.dart';

class TournamentNameViewModel extends ChangeNotifier{


  static  int? _selectedTournamentId ;

  int? get selectedTournamentId => _selectedTournamentId;

  void setSelectedTournamentId(int tournamentId) {
    _selectedTournamentId = tournamentId;
    notifyListeners();
  }
  String _selectedTournament = '';

  String get selectedTournament => _selectedTournament;

  void setSelectedTournament(String tournamentName){
    _selectedTournament = tournamentName;
    notifyListeners();
  }

  static int? _selectedMatchId;
  int? get selectedMatchId => _selectedMatchId;

  void setSelectedMatchId(int? matchId) {
    _selectedMatchId = matchId;
    notifyListeners();
  }


}