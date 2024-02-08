class Player{
  int? id;
  String? playerName;
  String? position;
  int? jerseyNo;
  final int? teamId;

  Player({ this.id, this.playerName, this.position, this.jerseyNo, this.teamId});

  Map<String, dynamic> toMap(int teamId){
    return{
      'playerName':playerName,
      'position': position,
      'jerseyNo': jerseyNo,
      'teamId': teamId
    };
  }

  Player.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      playerName = map['playerName'],
      position = map['position'],
      jerseyNo = map['jerseyNo'],
      teamId = map['teamId'];



}