class Player{
  int? id;
  String? playerName;
  String? position;
  int? jerseyNo;
  final int? teamId;

  Player({ this.id, this.playerName, this.position, this.jerseyNo, this.teamId});

  Player copyWith({int? id,int? teamId, String? playerName, String? position, int? jerseyNo}) {
    return Player(
      id: id ?? this.id,
      playerName: playerName ?? this.playerName,
      position: position ?? this.position,
      jerseyNo: jerseyNo ?? this.jerseyNo,
      teamId:  this.teamId,
    );
  }

  Map<String, dynamic> toMap(int teamId){
    return{
      'playerName':playerName,
      'position': position,
      'jerseyNo': jerseyNo,
      'teamId': teamId
    };
  }


}