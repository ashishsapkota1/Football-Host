class Matches{
  int? id;
  int? tournamentId;
  int? team1Id;
  int? team2Id;
  int? team1Score;
  int? team2Score;
  String? penaltyScore;
  Matches({this.id, this.tournamentId, this.team1Id, this.team2Id, this.team1Score, this.team2Score, this.penaltyScore});


  Matches copyWith({int? id, int? tournamentId, int? team1Id, int? team2Id, int? team1Score, int? team2Score, String? penaltyScore}){
    return Matches(
      id: id ?? this.id,
      tournamentId: this.tournamentId,
      team1Id: this.team1Id,
      team2Id: this.team2Id,
      team1Score: team1Score ?? this.team1Score,
      team2Score: team2Score ?? this.team2Score,
      penaltyScore: penaltyScore ?? this.penaltyScore
    );

  }

  Map<String, dynamic> toMap(int tournamentId, int team1Id, team2Id){
    return{
      "tournamentId" : tournamentId,
      "team1Id" : team1Id,
      "team2Id" : team2Id,
      "team1Score" : team1Score,
      "team2Score" : team2Score,
      "penaltyScore" : penaltyScore
    };
  }

}