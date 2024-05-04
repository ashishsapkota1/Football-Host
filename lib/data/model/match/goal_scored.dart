class GoalScorer {
  int? id;
  int? matchId;
  int? scorerId;
  int? assistId;
  int? goalTime;

  GoalScorer({
    this.id,
    this.matchId,
    this.scorerId,
    this.assistId,
    this.goalTime
});

Map<String, dynamic> toMap(){
  return {
    'matchId' : matchId,
    'scorerId' : scorerId,
    'assistId' : assistId,
    'goalTime' : goalTime
  };
}

  
  
}