import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/responsive.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/view/match-view/add_goal.dart';
import 'package:football_host/view/match-view/lineup.dart';
import 'package:football_host/view/match-view/timer.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';
import 'package:football_host/view_model/matchViewModel/score_view_model.dart';
import 'package:provider/provider.dart';
import '../../data/model/match/match_model.dart';
import '../../resources/utils/text_styles.dart';

class StartMatch extends StatefulWidget {
  final Matches matches;

  const StartMatch({super.key, required this.matches});

  @override
  State<StartMatch> createState() => _StartMatchState();
}

class _StartMatchState extends State<StartMatch> with TickerProviderStateMixin {
  late List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final matchViewModel = Provider.of<MatchViewModel>(context, listen: false);
    matchViewModel.getHasStarted(widget.matches.id!);
    bool hasStarted = matchViewModel.hasStarted;
    final scoreViewModel = Provider.of<ScoreViewModel>(context);
    print(' 2 $hasStarted');
    int team1Score = scoreViewModel.team1Score;
    int team2Score = scoreViewModel.team2Score;
    List<Widget> tabs = [
      LineUp(
        matchId: widget.matches.id,
          team1Id: widget.matches.team1Id,
          team2Id: widget.matches.team2Id,
          team1Name: widget.matches.team1Name,
          team2Name: widget.matches.team2Name),
      const MatchTimer(),
      AddGoal(
        matchId: widget.matches.id,
          team1Id: widget.matches.team1Id,
          team2Id: widget.matches.team2Id,
          team1Name: widget.matches.team1Name,
          team2Name: widget.matches.team2Name)
    ];
    return PopScope(
      canPop: !hasStarted,
      child: DefaultTabController(
          length: tabs.length,
          child: Builder(
            builder: (BuildContext context) {
              final TabController tabController =
                  DefaultTabController.of(context);
              tabController.addListener(() {
                if (tabController.indexIsChanging) {
                  tabController.index;
                }
              });
              return Scaffold(
                backgroundColor: AppColor.backGroundColor,
                appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(Responsive.screenHeight(context) * 0.3),
                  child: AppBar(
                    centerTitle: true,
                    backgroundColor: AppColor.appBarColor,
                    title: Text(
                      "${widget.matches.team1Name?.toUpperCase()} vs ${widget.matches.team2Name?.toUpperCase()}",
                      style: TextStyles.appBarText,
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.matches.team1Name!.toUpperCase(),
                            style: TextStyles.matchStyle,
                          ),
                          verticalSpacing(
                              space: Responsive.screenWidth(context) * 0.08),
                          Text(
                            widget.matches.team1Score != null && widget.matches.team1Score! > 0
                                ? widget.matches.team1Score!.toString()
                                : team1Score.toString(),
                            style: TextStyles.scoreStyle,
                          ),
                          verticalSpacing(
                              space: Responsive.screenWidth(context) * 0.04),
                          const Text(
                            '-',
                            style: TextStyles.scoreStyle,
                          ),
                          verticalSpacing(
                              space: Responsive.screenWidth(context) * 0.04),
                          Text(
                            widget.matches.team2Score != null && widget.matches.team2Score! > 0
                                ? widget.matches.team2Score!.toString()
                                : team2Score.toString(),
                            style: TextStyles.scoreStyle,
                          ),
                          verticalSpacing(
                              space: Responsive.screenWidth(context) * 0.08),
                          Text(
                            widget.matches.team2Name!.toUpperCase(),
                            style: TextStyles.matchStyle,
                          ),
                        ],
                      ),
                      expandedTitleScale: 2,
                    ),
                    bottom: TabBar(
                      controller: tabController,
                      labelStyle: TextStyles.tabBarStyle,
                      tabs: const [
                        Tab(
                          text: 'LineUp',
                        ),
                        Tab(
                          text: 'Timer',
                        ),
                        Tab(
                          text: 'Add Goal',
                        )
                      ],
                    ),
                  ),
                ),
                body: TabBarView(children: tabs),
              );
            },
          )),
    );
  }
}
