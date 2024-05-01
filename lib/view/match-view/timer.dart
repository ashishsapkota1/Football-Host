import 'package:flutter/material.dart';
import 'package:football_host/view_model/matchViewModel/match_timer_model.dart';
import 'package:provider/provider.dart';

import '../../resources/utils/text_styles.dart';

class MatchTimer extends StatelessWidget {
  const MatchTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<MatchTimerViewModel>(context);
    return Column(
      children: [
        const Text(
          "Time remaining:",
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
