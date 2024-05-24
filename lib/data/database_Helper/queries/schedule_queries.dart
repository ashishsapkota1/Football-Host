import 'package:football_host/data/database_Helper/database_helper.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/utils.dart';

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

  static Future<int?> getMatchNumber(int scheduleId) async {
    final db = await DbHelper.instance.db;
    List<Map<String, dynamic>> result = await db!.transaction((txn) async {
      return await txn.query('Schedule',
          columns: ['matchNumber'], where: 'id =?', whereArgs: [scheduleId]);
    });
    return result.isNotEmpty ? result.first['matchNumber'] : null;
  }

  static Future<void> updateSchedule() async {
    final db = await DbHelper.instance.db;
    try {
      await db!.transaction((txn) async {
        // Update team1Id based on match results
        await txn.rawUpdate('''
        UPDATE Schedule
        SET team1Id = (
          SELECT CASE 
                   WHEN m.team1Score > m.team2Score THEN m.team1Id 
                   WHEN m.team1Score < m.team2Score THEN m.team2Id
                   ELSE CASE 
                          WHEN m.penaltyScore1 > m.penaltyScore2 THEN m.team1Id 
                          ELSE m.team2Id 
                        END 
                 END
          FROM Match m
          WHERE m.matchNumber = Schedule.team1DependsOn 
            AND m.isFirstHalf = 1
            AND m.isSecondHalf = 1
        )
        WHERE team1Id = 0 OR team1Id IS NULL
      ''');

        // Update team1Name based on match results
        await txn.rawUpdate('''
        UPDATE Schedule
        SET team1Name = (
          SELECT CASE 
                   WHEN m.team1Score > m.team2Score THEN m.team1Name 
                   WHEN m.team1Score < m.team2Score THEN m.team2Name
                   ELSE CASE 
                          WHEN m.penaltyScore1 > m.penaltyScore2 THEN m.team1Name 
                          ELSE m.team2Name 
                        END 
                 END
          FROM Match m
          WHERE m.matchNumber = Schedule.team1DependsOn 
            AND m.isFirstHalf = 1
            AND m.isSecondHalf = 1
        )
        WHERE team1Name = '' OR team1Name IS NULL
      ''');

        // Update team2Id based on match results
        await txn.rawUpdate('''
        UPDATE Schedule
        SET team2Id = (
          SELECT CASE 
                   WHEN m.team1Score > m.team2Score THEN m.team1Id 
                   WHEN m.team1Score < m.team2Score THEN m.team2Id
                   ELSE CASE 
                          WHEN m.penaltyScore1 > m.penaltyScore2 THEN m.team1Id 
                          ELSE m.team2Id 
                        END 
                 END
          FROM Match m
          WHERE m.matchNumber = Schedule.team2DependsOn 
            AND m.isFirstHalf = 1
            AND m.isSecondHalf = 1
        )
        WHERE team2Id = 0 OR team2Id IS NULL
      ''');

        // Update team2Name based on match results
        await txn.rawUpdate('''
        UPDATE Schedule
        SET team2Name = (
          SELECT CASE 
                   WHEN m.team1Score > m.team2Score THEN m.team1Name 
                   WHEN m.team1Score < m.team2Score THEN m.team2Name
                   ELSE CASE 
                          WHEN m.penaltyScore1 > m.penaltyScore2 THEN m.team1Name 
                          ELSE m.team2Name 
                        END 
                 END
          FROM Match m
          WHERE m.matchNumber = Schedule.team2DependsOn 
            AND m.isFirstHalf = 1
            AND m.isSecondHalf = 1
        )
        WHERE team2Name = '' OR team2Name IS NULL
      ''');
      });
    } catch (e) {
      Utils.toastMessage(e.toString(), AppColor.toastColor);
    }
  }

}
