class GoalScorer {
  int? id;
  int? matchId;
  int? scorerId;
  int? goalTime;

  GoalScorer({
    this.id,
    this.matchId,
    this.scorerId,
    this.goalTime
});

Map<String, dynamic> toMap(){
  return {
    'matchId' : matchId,
    'scorerId' : scorerId,
    'goalTime' : goalTime
  };
}

  
  
}