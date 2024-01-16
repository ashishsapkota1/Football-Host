import 'package:football_host/model/teams_model.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Tournament extends HiveObject{
  @HiveField(0)
  String tournamentName;

  @HiveField(1)

  final HiveList<TeamName> teams = HiveList<TeamName>(Hive.box<TeamName>('teams'));

  Tournament({required this.tournamentName});
}