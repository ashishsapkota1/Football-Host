import 'package:flutter/foundation.dart';
import 'package:football_host/data/database_Helper/queries/schedule_queries.dart';

import '../../data/model/match/match_schedule_model.dart';

class ScheduleViewModel extends ChangeNotifier {
  late List<Schedule> _scheduleList = [];
  late int? _matchNumber;

  List<Schedule> get scheduleList => _scheduleList;

  int? get matchNumber => _matchNumber;

  Future<void> addSchedule(int tournamentId, Schedule schedule) async {
    final int? scheduleId =
        await ScheduleQueries.insertSchedule(tournamentId, schedule);
    if (scheduleId != null) {
      final newSchedule = Schedule(id: scheduleId);
      _scheduleList.add(newSchedule);
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('failed');
      }
    }
  }

  Future<void> getSchedule(int tournamentId) async {
    List<Schedule> schedule = await ScheduleQueries.getSchedule(tournamentId);
    _scheduleList = schedule;
    notifyListeners();
  }

  Future<void> getMatchNumber(int scheduleId) async {
    int? matchNumber = await ScheduleQueries.getMatchNumber(scheduleId);
    _matchNumber = matchNumber;
    notifyListeners();
  }

  Future<void> updateSchedule() async {
    await ScheduleQueries.updateSchedule();
    notifyListeners();
  }
}
