import 'package:football_host/data/model/team_model.dart';

class Tournament{
  final int? id;
  final String? name;


  Tournament({this.id, this.name});

  Tournament copyWith({int? id, String? name}) {
    return Tournament(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, Object?> toMap(){
    return {
      "name": name
    };
  }

  Tournament.fromMap(Map<String, dynamic> map)
  : id = map['id'],
    name = map['name'];
}