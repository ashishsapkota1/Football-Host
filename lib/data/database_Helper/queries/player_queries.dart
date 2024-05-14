import 'package:football_host/data/database_Helper/database_helper.dart';

import '../../model/player_model.dart';

class PlayerQueries{

  // Insert Players
  static Future<int?> insertPlayer(int teamId, Player player) async {
    final db = await DbHelper.instance.db;
    return await db?.insert('PLAYER', player.toMap(teamId));
  }
  //get playerName
 static Future<String?> getPlayerName(int playerId) async {
    final db = await DbHelper.instance.db;
    List<Map<String, dynamic>> results = await db!.query(
      'PLAYER',
      columns: ['playerName'],
      where: 'id = ?',
      whereArgs: [playerId],
    );
    if (results.isNotEmpty) {
      return results.first['playerName'] as String?;
    } else {
      return null;
    }
  }


  // Get Players
  static Future<List<Player>> getPlayers(int teamId) async {
    final db = await DbHelper.instance.db;
    final List<Map<String, dynamic>>? maps = await db
        ?.query('PLAYER', where: 'teamId = ?', whereArgs: [teamId]);
    return List.generate(maps!.length, (index) {
      return Player.fromMap(maps[index]);
    });
  }
}