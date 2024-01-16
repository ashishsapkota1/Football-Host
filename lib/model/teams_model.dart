import 'package:football_host/model/player_model.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)

class TeamName extends HiveObject{
  @HiveField(0)
  late String teamName;

  @HiveField(1)
  final playersName = HiveList<Player>(Hive.box<Player>('players'));

  TeamName({required this.teamName});

}