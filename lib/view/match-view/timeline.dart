import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';
import 'package:provider/provider.dart';

import '../../data/model/match/goal_scored.dart';
import '../../resources/utils/text_styles.dart';
import '../../view_model/matchViewModel/goal_scorer_view_model.dart';
import '../../view_model/player_view_model.dart';

class TimeLine extends StatefulWidget {
  final int? matchID;
  final String? team1Name;
  final String? team2Name;
  final int? team1Id;
  final int? team2Id;

  const TimeLine(
      {super.key,
        required this.matchID,
      required this.team1Name,
      required this.team2Name,
      required this.team1Id,
      required this.team2Id});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {

  @override
  Widget build(BuildContext context) {
    final goalScorerViewModel = Provider.of<GoalScorerViewModel>(context);
    final goalScorers = goalScorerViewModel.goalScorer;

    final team1GoalScorers =
        goalScorers.where((scorer) => scorer.teamId == widget.team1Id && scorer.matchId == widget.matchID).toList();
    final team2GoalScorers =
        goalScorers.where((scorer) => scorer.teamId == widget.team2Id && scorer.matchId == widget.matchID).toList();

    return Row(
      children: [
        _buildTeamColumn(team1GoalScorers, widget.team1Name!),
        _buildTeamColumn(team2GoalScorers, widget.team2Name!),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            horizontalSpacing(space: 8),
            const Divider(
              thickness: 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: goalScorers
                  .map((goalScorer) => Center(
                        child: FutureBuilder<String?>(
                          future: Provider.of<PlayerViewModel>(context,
                                  listen: false)
                              .getPlayerName(goalScorer.scorerId!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                  const Divider(
                                    thickness: 1,
                                  )
                                ],
                              );
                            } else {
                              return const Column(
                                children: [
                                   Text('No Player Picked'),
                                  Divider(
                                    thickness: 1,
                                  )
                                ],
                              );
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
