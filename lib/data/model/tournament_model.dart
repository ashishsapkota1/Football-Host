import 'package:football_host/data/model/team_model.dart';

class Tournament{
  final int? id;
  final String? name;
  final String? pole;


  Tournament({this.id, this.name, this.pole});

  Tournament copyWith({int? id, String? name, String? pole}) {
    return Tournament(
      id: id ?? this.id,
      name: name ?? this.name,
      pole: pole ?? this.pole
    );
  }

  Map<String, Object?> toMap(){
    return {
      "name": name,
      "pole": pole,
    };
  }

  Tournament.fromMap(Map<String, dynamic> map)
  : id = map['id'],
    name = map['name'],
    pole = map['pole'];
}