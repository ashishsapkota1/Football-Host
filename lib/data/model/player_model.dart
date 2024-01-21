class Player{
  int id;
  String playerName;
  String position;
  int jerseyNo;
  Player({required this.id, required this.playerName, required this.position, required this.jerseyNo});
  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'name':playerName,
      'position': position,
      'jerseyNo': jerseyNo
    };
  }


}