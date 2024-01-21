import 'package:football_host/data/model/player_model.dart';

class Team{
  int? id;
  final int? tournamentId;
  String? teamName;

  Team({this.id,this.teamName, this.tournamentId});

  Team copyWith({int? id,int? tournamentId, String? teamName}) {
    return Team(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      teamName: teamName ?? this.teamName,
    );
  }

  Map<String, Object?> toMap(){
    return {
      "tournamentId": tournamentId,
      "teamName": teamName
    };
  }

  Team.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        tournamentId = map["tournamentId"],
        teamName = map['teamName'];
}