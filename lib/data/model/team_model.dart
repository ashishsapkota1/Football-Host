

class Team{
  int? id;
  final int? tournamentId;
  String? teamName;

  Team({this.id,this.teamName, this.tournamentId});

  Team copyWith({int? id,int? tournamentId, String? teamName}) {
    return Team(
      id: id ?? this.id,
      tournamentId:  this.tournamentId,
      teamName: teamName ?? this.teamName,
    );
  }

  Map<String, Object?> toMap(int tournamentId){
    return {
      "tournamentId": tournamentId,
      "teamName": teamName
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'],
      tournamentId: map['tournamentId'],
      teamName: map['teamName'],
    );
  }

}