import 'package:flutter/material.dart';
import 'package:football_host/data/model/player_model.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/view_model/matchViewModel/goal_scorer_view_model.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';
import 'package:football_host/view_model/matchViewModel/score_view_model.dart';
import 'package:football_host/view_model/player_view_model.dart';
import 'package:provider/provider.dart';

import '../../resources/app_colors.dart';
import '../../resources/utils/responsive.dart';
import '../../resources/utils/text_styles.dart';

class AddGoal extends StatefulWidget {
  final int? matchId;
  final int? team1Id;
  final int? team2Id;
  final String? team1Name;
  final String? team2Name;

  const AddGoal(
      {super.key,
      required this.matchId,
      required this.team1Id,
      required this.team2Id,
      required this.team1Name,
      required this.team2Name});

  @override
  State<AddGoal> createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  bool isTeam1Selected = false;
  bool isTeam2Selected = false;
  bool isPlayerSelected = false;
   int selectedPlayerIndex = -1;
  late int goalScorerId;
  final List<Player> emptyList = [];

  @override
  Widget build(BuildContext context) {
    final matchViewModel = Provider.of<MatchViewModel>(context);
    bool matchStarted = matchViewModel.matchStarted;
    final scoreViewModel = Provider.of<ScoreViewModel>(context);
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final goalScorerViewModel = Provider.of<GoalScorerViewModel>(context);
    playerViewModel.getPlayers(widget.team1Id!);
    playerViewModel.get2Players(widget.team2Id!);
    final List<Player> player1 = playerViewModel.playerList;
    final List<Player> player2 = playerViewModel.playerList2;

    int team1Score = scoreViewModel.team1Score;
    int team2Score = scoreViewModel.team2Score;

    Widget listView = isTeam1Selected
        ? _listView(player1)
        : isTeam2Selected
            ? _listView(player2)
            : const SizedBox();
    return matchStarted
        ? SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Select scoring team",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                horizontalSpacing(space: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: isTeam1Selected,
                        onChanged: (value) {
                          setState(() {
                            isTeam1Selected = value ?? false;
                            isTeam2Selected = !isTeam1Selected;
                          });
                        }),
                    Text(
                      widget.team1Name!,
                      style: TextStyles.cardText,
                    ),
                  ],
                ),
                horizontalSpacing(space: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: isTeam2Selected,
                        onChanged: (value) {
                          setState(() {
                            isTeam2Selected = value ?? false;
                            isTeam1Selected = !isTeam2Selected;
                          });
                        }),
                    Text(
                      widget.team2Name!,
                      style: TextStyles.cardText,
                    ),
                  ],
                ),
                listView,
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.appBarColor),
                    ),
                    onPressed: () async {
                      if (isTeam1Selected) {
                        await scoreViewModel.addTeam1Goal(
                            widget.matchId!, team1Score);
                      } else if (isTeam2Selected) {
                        await scoreViewModel.addTeam2Goal(
                            widget.matchId!, team2Score);
                      }
                      await goalScorerViewModel.addGoalScorer(
                          widget.matchId!,
                          isTeam1Selected ? widget.team1Id! : widget.team2Id!,
                          goalScorerId,
                          2);
                    },
                    child: const Text(
                      'Add goal',
                      style: TextStyles.tabBarStyle,
                    )),
              ],
            ),
          )
        : const Center(
            child: Text(
            'Match hasn\'t been started yet',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ));
  }

  Widget _listView(List<Player> player) {
    return SizedBox(
      height: Responsive.screenHeight(context) * 0.09,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          itemCount: player.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final isSelected = index == selectedPlayerIndex;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlayerIndex = index;
                      });
                      goalScorerId = player[index].id!;
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: isSelected ? Colors.blue : AppColor.lineUpColor,
                      child: Center(
                        child: Text(player[index].jerseyNo!.toString()),
                      ),
                    ),
                  ),
                ),
                Text(
                  player[index].playerName!.split(RegExp('\\s+'))[0],
                  style: TextStyles.draggedStyle,
                )
              ],
            );
          }),
    );
  }
}
