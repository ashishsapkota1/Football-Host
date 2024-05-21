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
  bool isFirstHalf;
  bool isSecondHalf;
  bool hasStarted;
  int? matchNumber;
  String? penaltyScore;
  int? matchTime;

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
      this.isFirstHalf = false,
      this.isSecondHalf = false,
      this.hasStarted = false,
      this.matchNumber,
      this.penaltyScore,
      this.matchTime});

  Map<String, dynamic> toMap() {
    return {
      "tournamentId": tournamentId,
      "scheduleId": scheduleId,
      "team1Id": team1Id,
      "team2Id": team2Id,
      'team1Name': team1Name,
      "team2Name": team2Name,
      "team1Score": team1Score,
      "team2Score": team2Score,
      "isFirstHalf": isFirstHalf,
      "isSecondHalf": isSecondHalf,
      "hasStarted": hasStarted,
      "matchNumber" : matchNumber,
      "penaltyScore": penaltyScore,
      "matchTime": matchTime
    };
  }

  Matches.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        tournamentId = map['tournamentId'],
        scheduleId = map['scheduleId'],
        team1Id = map['team1Id'],
        team2Id = map['team2Id'],
        team1Name = map['team1Name'],
        team2Name = map['team2Name'],
        team1Score = map['team1Score'],
        team2Score = map['team2Score'],
        isFirstHalf = map['isFirstHalf'] == 1,
        isSecondHalf = map['isSecondHalf'] == 1,
        hasStarted = map['hasStarted'] == 1,
        matchNumber = map['matchNumber'],
        penaltyScore = map['penaltyScore'],
        matchTime = map['matchTime'];
}
