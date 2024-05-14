import 'package:football_host/data/database_Helper/database_helper.dart';

import '../../model/match/match_schedule_model.dart';

class ScheduleQueries {
  // Insert Schedule
  static Future<int?> insertSchedule(int tournamentId, Schedule schedule) async {
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
}