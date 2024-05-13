import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:provider/provider.dart';

import '../../data/model/match/goal_scored.dart';
import '../../resources/utils/text_styles.dart';
import '../../view_model/matchViewModel/goal_scorer_view_model.dart';
import '../../view_model/player_view_model.dart';

class TimeLine extends StatefulWidget {
  final String? team1Name;
  final String? team2name;
  const TimeLine({super.key, required this.team1Name, required this.team2name});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    final goalScorerViewModel = Provider.of<GoalScorerViewModel>(context);
    final goalScorers = goalScorerViewModel.goalScorer;

    final team1GoalScorers = goalScorers.where((scorer) => scorer.teamId == 1).toList();
    final team2GoalScorers = goalScorers.where((scorer) => scorer.teamId == 2).toList();

    return Row(
      children: [
        _buildTeamColumn(team1GoalScorers, widget.team1Name!),
        _buildTeamColumn(team2GoalScorers, widget.team2name!),
      ],
    );
  }

  Widget _buildTeamColumn(List<GoalScorer> goalScorers, String teamName) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                teamName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            horizontalSpacing(space: 8),
            const Divider(thickness: 3,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: goalScorers
                  .map((goalScorer) => Center(
                child: FutureBuilder<String?>(
                  future: Provider.of<PlayerViewModel>(context, listen: false).getPlayerName(goalScorer.scorerId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('...');
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                snapshot.data!,
                                style: TextStyles.timeLineStyle,
                              ),
                              verticalSpacing(space: 10),
                              Text(
                                '${goalScorer.goalTime}\'',
                                style: TextStyles.timeLineStyle,
                              ),
                            ],
                          ),
                          const Divider(thickness: 1,)
                        ],
                      );
                    } else {
                      return const Text('No data available');
                    }
                  },
                ),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
