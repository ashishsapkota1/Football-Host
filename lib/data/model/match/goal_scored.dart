class GoalScorer {
  int? id;
  int? matchId;
  int? teamId;
  int? scorerId;
  int? goalTime;

  GoalScorer({
    this.id,
    this.matchId,
    this.teamId,
    this.scorerId,
    this.goalTime
});

Map<String, dynamic> toMap(){
  return {
    'matchId' : matchId,
    'teamId' : teamId,
    'scorerId' : scorerId,
    'goalTime' : goalTime
  };
}

  
  
}