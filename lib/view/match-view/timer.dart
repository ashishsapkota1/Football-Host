import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/view_model/matchViewModel/match_timer_model.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';
import 'package:football_host/view_model/matchViewModel/score_view_model.dart';
import 'package:provider/provider.dart';

import '../../resources/app_colors.dart';
import '../../resources/utils/text_styles.dart';
import '../../view_model/matchViewModel/schedule_view_model.dart';

class MatchTimer extends StatefulWidget {
  final int? matchId;

  const MatchTimer({super.key, required this.matchId});

  @override
  State<MatchTimer> createState() => _MatchTimerState();
}

class _MatchTimerState extends State<MatchTimer> {
  TextEditingController team1ScoreController = TextEditingController();
  TextEditingController team2ScoreController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    team1ScoreController.dispose();
    team2ScoreController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final matchViewModel = Provider.of<MatchViewModel>(context, listen: false);
    final scoreViewModel = Provider.of<ScoreViewModel>(context, listen: false);


    final timerProvider =
        Provider.of<MatchTimerViewModel>(context, listen: false);

    bool isFirstHalf = matchViewModel.isFirstHalf;
    bool isSecondHalf = matchViewModel.isSecondHalf;
    if (matchViewModel.hasStarted == true &&
        timerProvider.remainingTimeInSec == 0) {
      if (isFirstHalf == false && isSecondHalf == false) {
        matchViewModel.matchStarted(widget.matchId!, false);
        matchViewModel.firstHalf(widget.matchId!, true);
      }
      if (isFirstHalf == true && isSecondHalf == false) {
        matchViewModel.matchStarted(widget.matchId!, false);
        matchViewModel.secondHalf(widget.matchId!, true);
      }
    }
    matchViewModel.getHasStarted(widget.matchId!);
    matchViewModel.getFirstHalf(widget.matchId!);
    matchViewModel.getSecondHalf(widget.matchId!);
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<MatchTimerViewModel>(context);
    final scoreViewModel = Provider.of<ScoreViewModel>(context, listen: false);
    final scheduleViewModel =
        Provider.of<ScheduleViewModel>(context, listen: false);
    final matchViewModel = Provider.of<MatchViewModel>(context, listen: false);

    if (matchViewModel.isFirstHalf == true &&
        matchViewModel.isSecondHalf == true) {
      if (scoreViewModel.team1Score == scoreViewModel.team2Score) {
        if (scoreViewModel.team1PenaltyScore ==
            scoreViewModel.team2PenaltyScore) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              children: [
                const Text(
                  'Enter penalty Score',
                  style: TextStyles.cardText,
                ),
                verticalSpacing(space: 8),
                TextField(
                  controller: team1ScoreController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Team1 Score',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                verticalSpacing(space: 8),
                TextField(
                  controller: team2ScoreController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Team2 Score',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                verticalSpacing(space: 8),
                ElevatedButton(
                    onPressed: () {
                      scoreViewModel.addTeam1PenaltyGoal(widget.matchId!,
                          int.tryParse(team1ScoreController.text)!);
                      scoreViewModel.addTeam2PenaltyGoal(widget.matchId!,
                          int.tryParse(team2ScoreController.text)!);
                      scheduleViewModel.updateSchedule();
                      team1ScoreController.clear();
                      team2ScoreController.clear();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.appBarColor)),
                    child: const Text(
                      'Add',
                      style: TextStyles.buttonText,
                    ))
              ],
            ),
          );
        }
      } else {
        scheduleViewModel.updateSchedule();
      }
    }
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
