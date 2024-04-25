import 'package:flutter/material.dart';

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
  String? goalScorer;
  String? assistedBy;
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
      this.penaltyScore,
      this.goalScorer,
      this.assistedBy,
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
      "penaltyScore": penaltyScore,
      "goalScorer": goalScorer,
      "assistedBy": assistedBy,
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
        penaltyScore = map['penaltyScore'],
        goalScorer = map['goalScorer'],
        assistedBy = map['assistedBy'],
        matchTime = map['matchTime'];
}
