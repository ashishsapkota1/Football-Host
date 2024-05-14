import 'package:football_host/data/database_Helper/database_helper.dart';

import '../../model/team_model.dart';

class TeamQueries {
  // Get Teams
  static Future<List<Team>> getTeams(int tournamentId) async {
    final db = await DbHelper.instance.db;
    final List<Map<String, dynamic>>? maps = await db
        ?.query('TEAM', where: 'tournamentId = ?', whereArgs: [tournamentId]);
    return List.generate(maps!.length, (index) {
      return Team.fromMap(maps[index]);
    });
  }

  // Insert Teams
  static Future<int?> insertTeams(int tournamentId, Team team) async {
    final db = await DbHelper.instance.db;
    return await db?.insert('TEAM', team.toMap(tournamentId));
  }

  //Delete teams
  static Future<int> deleteTeam(int id) async {
    final db = await DbHelper.instance.db;
    return await db!.delete('TEAM', where: "id =?", whereArgs: [id]);
  }

  static Future getTeamNameById(int teamId) async {
    final db = await DbHelper.instance.db;
    List<Map<String, dynamic>> result = await db!.query(
      'TEAM',
      columns: ['teamName'],
      where: 'id = ?',
      whereArgs: [teamId],
    );

    if (result.isNotEmpty) {
      return result.first['teamName'];
    } else {
      return [];
    }
  }
}
