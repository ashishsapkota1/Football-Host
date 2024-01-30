class MatchSchedule{
  int? id;
  int? tournamentId;
  int? team1Id;
  String? team1Name;
  String? team2Name;
  int? team2Id;

  MatchSchedule({this.id,this.tournamentId, this.team1Id, this.team2Id, this.team1Name, this.team2Name});

  MatchSchedule copyWith({int? id,int? tournamentId,int? team1Id, int? team2Id, String? team1Name, String? team2Name}) {
    return MatchSchedule(
      id:  id ?? this.id,
      tournamentId:  this.tournamentId,
      team1Id:  this.team1Id,
      team2Id:  this.team2Id,
      team1Name: team1Name ?? this.team1Name,
      team2Name: team2Name ?? this.team2Name
    );
  }

  Map<String, dynamic> toMap(int tournamentId, int team1Id, int team2Id){
    return {
      "tournamentId" : tournamentId,
      "team1Id" : team1Id,
      "team2Id" : team2Id,
      "team1Name" : team1Name,
      "team2Name": team2Name

    };
  }
}