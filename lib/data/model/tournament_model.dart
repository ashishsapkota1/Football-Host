import 'package:football_host/data/model/team_model.dart';

class Tournament{
  int id;
  String name;
  late List<Team> team;

  Tournament({required this.id, required this.name, required this.team});


}