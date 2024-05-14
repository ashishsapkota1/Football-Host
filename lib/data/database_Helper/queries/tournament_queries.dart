import 'package:football_host/data/database_Helper/database_helper.dart';

import '../../model/tournament_model.dart';

class TournamentQueries{
  // Insert Tournaments
  static Future<int?> insert(Tournament tournament) async {
    final db = await DbHelper.instance.db;
    return db!.transaction((txn) async {
      return await txn.insert('TOURNAMENT', tournament.toMap());
    });
  }

  // Get Tournaments
  static Future<List<Map<String, dynamic>>?> getTournaments() async {
    final db = await DbHelper.instance.db;
    return db!.transaction((txn) async {
      return await txn.query('TOURNAMENT');
    });
  }

  //Delete Tournament
  static Future<int> deleteTournament(int id) async {
    final db= await DbHelper.instance.db;
    return await db!
        .delete("TOURNAMENT", where: "id = ?", whereArgs: [id]);
  }

  static Future<Tournament> insertPoles(
      Tournament tournament, String poleFormation) async {
    final db= await DbHelper.instance.db;
    try {
      await db!.update('TOURNAMENT', {'pole': poleFormation},
          where: "id = ?", whereArgs: [tournament.id]);
      Tournament updatedTournament = tournament.copyWith(pole: poleFormation);
      return updatedTournament;
    } catch (e) {
      throw Exception('failed to add poles.');
    }
  }
}