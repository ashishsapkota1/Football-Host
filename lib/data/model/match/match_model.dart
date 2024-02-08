class Matches {
  int? id;
  int? tournamentId;
  int? scheduleId;
  int? team1Id;
  int? team2Id;
  String? team1Name;
  String? team2Name;
  int? team1Score;
  int? team2Score;
  String? penaltyScore;
  Matches(
      {this.id,
      this.tournamentId,
      this.scheduleId,
      this.team1Id,
      this.team2Id,
      this.team1Name,
      this.team2Name,
      this.team1Score,
      this.team2Score,
      this.penaltyScore});

  Matches copyWith(
      {int? id,
      int? tournamentId,
      int? scheduleId,
      int? team1Id,
      int? team2Id,
      String? team1Name,
      String? team2Name,
      int? team1Score,
      int? team2Score,
      String? penaltyScore}) {
    return Matches(
        id: id ?? this.id,
        tournamentId: this.tournamentId,
        scheduleId: this.scheduleId,
        team1Id: this.team1Id,
        team2Id: this.team2Id,
        team1Name: this.team1Name,
        team2Name: this.team2Name,
        team1Score: team1Score ?? this.team1Score,
        team2Score: team2Score ?? this.team2Score,
        penaltyScore: penaltyScore ?? this.penaltyScore);
  }

  Map<String, dynamic> toMap() {
    return {
      "tournamentId": tournamentId,
      "scheduleId": scheduleId,
      "team1Id": team1Id,
      "team2Id": team2Id,
      'team1Name' : team1Name,
      "team2Name": team2Name,
      "team1Score": team1Score,
      "team2Score": team2Score,
      "penaltyScore": penaltyScore
    };
  }
}
