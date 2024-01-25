import 'dart:core';

class MatchSchedule{
  int? id;
  int? tournamentId;
  int? team1Id;
  int? team2Id;

  MatchSchedule({this.id,this.tournamentId, this.team1Id, this.team2Id});

  MatchSchedule copyWith({int? id,int? tournamentId,int? team1Id, int? team2Id}) {
    return MatchSchedule(
      id: id ?? this.id,
      tournamentId:  this.tournamentId,
      team1Id: team1Id ?? this.team1Id,
      team2Id: team2Id ?? this.team2Id
    );
  }

  Map<String, Object> toMap(int tournamentId, int team1Id, int team2Id){
    return {
      "tournamentId" : tournamentId,
      "team1Id" : team1Id,
      "team2Id" : team2Id


    };
  }
}