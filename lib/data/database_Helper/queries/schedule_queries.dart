import 'package:football_host/data/database_Helper/database_helper.dart';

import '../../model/match/match_schedule_model.dart';

class ScheduleQueries {
  // Insert Schedule
  static Future<int?> insertSchedule(
      int tournamentId, Schedule schedule) async {
    final db = await DbHelper.instance.db;
    return db!.insert('Schedule', schedule.toMap(tournamentId));
  }

  // Get Schedule
  static Future<List<Schedule>> getSchedule(int tournamentId) async {
    final db = await DbHelper.instance.db;
    final List<Map<String, dynamic>>? maps = await db?.query('Schedule',
        where: 'tournamentId = ? ', whereArgs: [tournamentId]);
    return List.generate(maps!.length, (index) {
      return Schedule.fromMap(maps[index]);
    });
  }

  static Future<void> updateSchedule() async {
    final db = await DbHelper.instance.db;
    try {
      await db!.transaction((txn) async {
        print('Updating team1Id and team1Name...');
        int team1IdUpdated = await txn.rawUpdate('''
        UPDATE Schedule
        SET team1Id = (
          SELECT CASE WHEN m.team1Score > m.team2Score THEN m.team1Id ELSE m.team2Id END
          FROM Match m
          WHERE m.scheduleId = Schedule.team1DependsOn 
            AND m.isFirstHalf = 1
            AND m.isSecondHalf = 1
        )
        WHERE team1Id IS NULL
      ''');
        print('team1Id updated: $team1IdUpdated rows');

        int team1NameUpdated = await txn.rawUpdate('''
        UPDATE Schedule
        SET team1Name = (
          SELECT CASE WHEN m.team1Score > m.team2Score THEN m.team1Name ELSE m.team2Name END
          FROM Match m
          WHERE m.scheduleId = Schedule.team1DependsOn 
            AND m.isFirstHalf = 1
            AND m.isSecondHalf = 1
        )
        WHERE team1Name IS Null
      ''');
        print('team1Name updated: $team1NameUpdated rows');

        int team2IdUpdated = await txn.rawUpdate('''
        UPDATE Schedule
        SET team2Id = (
          SELECT CASE WHEN m.team1Score > m.team2Score THEN m.team1Id ELSE m.team2Id END
          FROM Match m
         WHERE m.scheduleId = Schedule.team2DependsOn 
            AND m.isFirstHalf = 1
            AND m.isSecondHalf = 1
        )
        WHERE team2Id IS NULL
      ''');
        print('team2Id updated: $team2IdUpdated rows');

        int team2NameUpdated = await txn.rawUpdate('''
        UPDATE Schedule
        SET team2Name = (
          SELECT CASE WHEN m.team1Score > m.team2Score THEN m.team1Name ELSE m.team2Name END
          FROM Match m
          WHERE m.scheduleId = Schedule.team2DependsOn 
            AND m.isFirstHalf = 1
            AND m.isSecondHalf = 1
        )
        WHERE team2Name IS NULL
      ''');
        print('team1Name updated: $team2NameUpdated rows');
      });
    } catch (e) {
      print(e.toString());
    }
  }

}
