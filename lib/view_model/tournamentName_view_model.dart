import 'package:flutter/cupertino.dart';

class TournamentNameViewModel extends ChangeNotifier{


  late int? _selectedTournamentId ;

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


}