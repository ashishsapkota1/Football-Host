import 'package:flutter/material.dart';
import 'package:football_host/view_model/matchViewModel/match_timer_model.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';
import 'package:provider/provider.dart';

import '../../resources/utils/text_styles.dart';
import '../../view_model/matchViewModel/schedule_view_model.dart';

class MatchTimer extends StatefulWidget {
  final int? matchId;

  const MatchTimer({super.key, required this.matchId});

  @override
  State<MatchTimer> createState() => _MatchTimerState();
}

class _MatchTimerState extends State<MatchTimer> {
  @override
  void initState()  {
    super.initState();
    final matchViewModel = Provider.of<MatchViewModel>(context, listen: false);

    final timerProvider =
        Provider.of<MatchTimerViewModel>(context, listen: false);
    final scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);
    bool isFirstHalf = matchViewModel.isFirstHalf;
    bool isSecondHalf = matchViewModel.isSecondHalf;
    if (matchViewModel.hasStarted == true &&
        timerProvider.remainingTimeInSec == 0) {
      if (isFirstHalf == false && isSecondHalf == false) {
         matchViewModel.matchStarted(widget.matchId!, false);
         matchViewModel.firstHalf(widget.matchId!, true);
      } else if (isFirstHalf == true && isSecondHalf == false) {
         matchViewModel.matchStarted(widget.matchId!, false);
         matchViewModel.secondHalf(widget.matchId!, true);
         scheduleViewModel.updateSchedule();

      }
    }
    matchViewModel.getHasStarted(widget.matchId!);
    matchViewModel.getFirstHalf(widget.matchId!);
    matchViewModel.getSecondHalf(widget.matchId!);
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<MatchTimerViewModel>(context);

    return Column(
      children: [
        const Text(
          "Time elapsed:",
          style: TextStyles.timerStyle,
        ),
        Text(
          timerProvider.remainingTime,
          style: TextStyles.timerStyle,
        ),
      ],
    );
  }
}
