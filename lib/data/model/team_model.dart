
class Team{
  int? id;
  final int? tournamentId;
  String? teamName;

  Team({this.id,this.teamName, this.tournamentId});

  Map<String, Object?> toMap(int tournamentId){
    return {
      "tournamentId": tournamentId,
      "teamName": teamName
    };
  }

  Team.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        tournamentId = map['tournamentId'],
        teamName = map['teamName'];


}