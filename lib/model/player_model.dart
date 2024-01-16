import 'package:hive/hive.dart';

@HiveType(typeId: 2)

class Player extends HiveObject{
  @HiveField(0)
  late String playerName;

  @HiveField(1)
  late int jerseyNo;

  @HiveField(2)
  late String position;
  Player({required this.playerName, required this.jerseyNo, required this.position});
}