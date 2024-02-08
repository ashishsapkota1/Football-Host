

import 'package:flutter/cupertino.dart';
import 'package:football_host/data/database_Helper/database_helper.dart';
import '../../data/model/match/match_schedule_model.dart';


class ScheduleViewModel extends ChangeNotifier{
  late List<Schedule> _scheduleList = [];
  List<Schedule> get scheduleList => _scheduleList;

Future<void> addSchedule(int tournamentId, Schedule schedule) async{
  final int? scheduleId = await DbHelper.instance.insertSchedule(tournamentId, schedule);
  if(scheduleId != null){
    final newSchedule = Schedule(id: scheduleId);
    _scheduleList.add(newSchedule);
    notifyListeners();
  }else{
    print('failed');
  }
}

Future<void> getSchedule(int tournamentId) async{
  List<Schedule> schedule = await DbHelper.instance.getSchedule(tournamentId);
  _scheduleList = schedule;
  notifyListeners();
}

}
