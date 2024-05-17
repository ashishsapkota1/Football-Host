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

  static Future<List<Schedule>> updateSchedule() async {
    final db = await DbHelper.instance.db;
    List<Map<String, dynamic>>? maps = await db!.transaction((txn) async {
      await txn.rawUpdate(
          '''
      UPDATE Schedule
      SET team1Id = (
        SELECT 
          CASE
            WHEN m.team1Score > m.team2Score THEN m.team1Id
            WHEN m.team2Score > m.team1Score THEN m.team2Id
            ELSE NULL -- Handle draw or undetermined results
          END
        FROM MATCH m
        WHERE m.scheduleId = Schedule.team1DependsOn
          AND m.isFirstHalf = 1
          AND m.isSecondHalf = 1
      )
      WHERE team1DependsOn IS NOT NULL;
      '''
      );

      await txn.rawUpdate(
          '''
      UPDATE Schedule
      SET team1Name = (
        SELECT 
          CASE
            WHEN m.team1Score > m.team2Score THEN m.team1Name
            WHEN m.team2Score > m.team1Score THEN m.team2Name
            ELSE NULL -- Handle draw or undetermined results
          END
        FROM MATCH m
        WHERE m.scheduleId = Schedule.team1DependsOn
          AND m.isFirstHalf = 1
          AND m.isSecondHalf = 1
      )
      WHERE team1DependsOn IS NOT NULL;
      '''
      );

      await txn.rawUpdate(
          '''
      UPDATE Schedule
      SET team2Id = (
        SELECT 
          CASE
            WHEN m.team1Score > m.team2Score THEN m.team1Id
            WHEN m.team2Score > m.team1Score THEN m.team2Id
            ELSE NULL -- Handle draw or undetermined results
          END
        FROM MATCH m
        WHERE m.scheduleId = Schedule.team2DependsOn
          AND m.isFirstHalf = 1
          AND m.isSecondHalf = 1
      )
      WHERE team2DependsOn IS NOT NULL;
      '''
      );

      await txn.rawUpdate(
          '''
      UPDATE Schedule
      SET team2Name = (
        SELECT 
          CASE
            WHEN m.team1Score > m.team2Score THEN m.team1Name
            WHEN m.team2Score > m.team1Score THEN m.team2Name
            ELSE NULL -- Handle draw or undetermined results
          END
        FROM MATCH m
        WHERE m.scheduleId = Schedule.team2DependsOn
          AND m.isFirstHalf = 1
          AND m.isSecondHalf = 1
      )
      WHERE team2DependsOn IS NOT NULL;
      '''
      );
      return null;
    });
    return List.generate(maps!.length, (index) {
      return Schedule.fromMap(maps[index]);
    });
  }

}
