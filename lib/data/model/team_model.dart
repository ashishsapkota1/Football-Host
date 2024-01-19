import 'package:football_host/data/model/player_model.dart';

class Team{
  int id;
  String teamName;
  List<Player> players;

  Team({required this.id, required this.teamName, required this.players});
}