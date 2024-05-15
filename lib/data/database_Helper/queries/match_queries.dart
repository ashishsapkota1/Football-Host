import 'package:football_host/data/database_Helper/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/match/goal_scored.dart';
import '../../model/match/match_model.dart';

class MatchQueries {
  // Insert Matches
  static Future<int?> insertMatches(int tournamentId, Matches matches) async {
    final db = await DbHelper.instance.db;
    return db?.insert('MATCH', matches.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get Matches
  static Future<List<Matches>> getMatches(int tournamentId) async {
    final db = await DbHelper.instance.db;
    final List<Map<String, dynamic>>? maps = await db
        ?.query('MATCH', where: 'tournamentId = ?', whereArgs: [tournamentId]);
    return List.generate(maps!.length, (index) {
      return Matches.fromMap(maps[index]);
    });
  }

  //Insert GoalScorer
  static Future<int?> addGoalScorer(GoalScorer goalScorer) async {
    final db = await DbHelper.instance.db;
    return db!.transaction((txn) async {
      return await txn.insert('GOALSCORER', goalScorer.toMap());
    });
  }

  //Insert time
  static Future<int?> insertMatchTime(int matchId, int matchTime) async {
    final db = await DbHelper.instance.db;
    return db!.transaction((txn) async {
      return await txn.update("MATCH", {'matchTime': matchTime},
          where: 'id = ?', whereArgs: [matchId]);
    });
  }

  static Future<int?> addTeam1Goal(int matchId, int goalNumber) async {
    final db = await DbHelper.instance.db;
    return db!.transaction((txn) async {
      return await txn.update("MATCH", {'team1Score': goalNumber},
          where: "id = ?", whereArgs: [matchId]);
    });
  }

  static Future<int?> addTeam2Goal(int matchId, int goalNumber) async {
    final db = await DbHelper.instance.db;
    return db!.transaction((txn) async {
      return await txn.update("MATCH", {'team2Score': goalNumber},
          where: "id = ?", whereArgs: [matchId]);
    });
  }

  static Future<int?> getTeam1Score(int matchId) async {
    final db = await DbHelper.instance.db;
    List<Map<String, dynamic>> result = await db!.transaction((txn) async {
      return await txn.query('MATCH',
          columns: ['team1Score'], where: 'id = ?', whereArgs: [matchId]);
    });
    return result.isNotEmpty ? result.first['team1Score'] : null;
  }

  static Future<int?> getTeam2Score(int matchId) async {
    final db = await DbHelper.instance.db;
    List<Map<String, dynamic>> result = await db!.transaction((txn) async {
      return await txn.query('MATCH',
          columns: ['team2Score'], where: 'id = ?', whereArgs: [matchId]);
    });
    return result.isNotEmpty ? result.first['team2Score'] : null;
  }

  //update 1stHalf
  static Future<int?> update1stHalf(int matchId, bool isFirstHalf) async {
    final db = await DbHelper.instance.db;
    await db!.transaction((txn) async {
      await txn.update('MATCH', {'isFirstHalf': isFirstHalf ? 1 : 0},
          where: "id = ?", whereArgs: [matchId]);
    });
    return null;
  }

  //update 2ndHalf

  static Future<int?> update2ndHalf(int matchId, bool isSecondHalf) async {
    final db = await DbHelper.instance.db;
    await db!.transaction((txn) async {
      await txn.update('MATCH', {'isSecondHalf': isSecondHalf ? 1 : 0},
          where: "id = ?", whereArgs: [matchId]);
    });
    return null;
  }

  //update hasStarted
  static Future<int?> updateHasStarted(int matchId, bool hasStarted) async {
    final db = await DbHelper.instance.db;
    await db!.transaction((txn) async {
      await txn.update('MATCH', {'hasStarted': hasStarted ? 1 : 0},
          where: "id = ?", whereArgs: [matchId]);
    });
    return null;
  }

  //Get hasStarted
  static Future<int?> getHasStarted(int matchId) async {
    final db = await DbHelper.instance.db;
    List<Map<String, dynamic>> result = await db!.transaction((txn) async {
      return await txn.query('MATCH',
          columns: ['hasStarted'], where: 'id = ?', whereArgs: [matchId]);
    });
    return result.isNotEmpty ? result.first['hasStarted'] : null;
  }

  static Future<int?> get1stHalf(int matchId) async {
    final db = await DbHelper.instance.db;
    List<Map<String, dynamic>> result = await db!.transaction((txn) async {
      return await txn.query('MATCH',
          columns: ['isFirstHalf'], where: 'id = ?', whereArgs: [matchId]);
    });
    return result.isNotEmpty ? result.first['isFirstHalf'] : null;
  }

  static Future<int?> get2ndHalf(int matchId) async {
    final db = await DbHelper.instance.db;
    List<Map<String, dynamic>> result = await db!.transaction((txn) async {
      return await txn.query('MATCH',
          columns: ['isSecondHalf'], where: 'id = ?', whereArgs: [matchId]);
    });
    return result.isNotEmpty ? result.first['isSecondHalf'] : null;
  }

}
