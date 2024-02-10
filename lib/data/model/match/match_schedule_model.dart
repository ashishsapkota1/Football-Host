class Schedule {
  int? id;
  int? tournamentId;
  int? team1Id;
  int? team2Id;
  String? team1Name;
  String? team2Name;
  int? team1DependsOn;
  int? team2DependsOn;
  int? matchNumber;
  int? roundNumber;
  String? roundName;

  Schedule(
      {this.id,
      this.tournamentId,
      this.team1Id,
      this.team2Id,
      this.team1Name,
      this.team2Name,
      this.team1DependsOn,
      this.team2DependsOn,
      this.matchNumber,
      this.roundNumber,
      this.roundName});

  Map<String, dynamic> toMap(int tournamentId) {
    return {
      "tournamentId": tournamentId,
      "team1Id": team1Id,
      "team2Id": team2Id,
      "team1Name": team1Name ,
      "team2Name": team2Name ,
      "team1DependsOn": team1DependsOn,
      "team2DependsOn": team2DependsOn,
      "matchNumber": matchNumber,
      "roundNumber": roundNumber,
      "roundName": roundName
    };
  }

  Schedule.fromMap(Map<String, dynamic> map)
  : id = map['id'],
    tournamentId = map['tournamentId'],
    team1Id = map['team1Id'],
    team2Id = map['team2Id'],
    team1Name = map['team1Name'],
    team2Name = map['team2Name'],
    team1DependsOn = map['team1DependsOn'],
    team2DependsOn = map['team2DependsOn'],
    matchNumber = map['matchNumber'],
    roundNumber = map['roundNumber'],
    roundName = map['roundName'];
}
