import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/responsive.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/view/match-view/add_goal.dart';
import 'package:football_host/view/match-view/lineup.dart';
import 'package:football_host/view/match-view/timeline.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final matchViewModel = Provider.of<MatchViewModel>(context, listen: false);
    matchViewModel.getFirstHalf(widget.matches.id!);
    matchViewModel.getHasStarted(widget.matches.id!);
    matchViewModel.getSecondHalf(widget.matches.id!);
    final scoreViewModel = Provider.of<ScoreViewModel>(context, listen: false);
    scoreViewModel.getTeam1Score(widget.matches.id!);
    scoreViewModel.getTeam2Score(widget.matches.id!);

    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final scoreViewModel = Provider.of<ScoreViewModel>(context);
    int team1Score = scoreViewModel.team1Score;
    int team2Score = scoreViewModel.team2Score;
    List<Widget> tabs = [
      LineUp(
          matchId: widget.matches.id,
          team1Id: widget.matches.team1Id,
          team2Id: widget.matches.team2Id,
          team1Name: widget.matches.team1Name,
          team2Name: widget.matches.team2Name),
      MatchTimer(matchId: widget.matches.id),
      AddGoal(
          matchId: widget.matches.id,
          team1Id: widget.matches.team1Id,
          team2Id: widget.matches.team2Id,
          team1Name: widget.matches.team1Name,
          team2Name: widget.matches.team2Name),
      TimeLine(
        matchID: widget.matches.id,
        team1Name: widget.matches.team1Name,
        team2Name: widget.matches.team2Name,
        team1Id: widget.matches.team1Id,
        team2Id: widget.matches.team2Id,
      )
    ];
    return Consumer<MatchViewModel>(
      builder: (context, viewModel, _) {
        return PopScope(
          canPop: !viewModel.hasStarted,
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
                      preferredSize: Size.fromHeight(
                          Responsive.screenHeight(context) * 0.3),
                      child: isLoading
                          ? const SizedBox()
                          : AppBar(
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
                                        space: Responsive.screenWidth(context) *
                                            0.08),
                                    Text(
                                      team1Score.toString(),
                                      style: TextStyles.scoreStyle,
                                    ),
                                    verticalSpacing(
                                        space: Responsive.screenWidth(context) *
                                            0.04),
                                    const Text(
                                      '-',
                                      style: TextStyles.scoreStyle,
                                    ),
                                    verticalSpacing(
                                        space: Responsive.screenWidth(context) *
                                            0.04),
                                    Text(
                                      team2Score.toString(),
                                      style: TextStyles.scoreStyle,
                                    ),
                                    verticalSpacing(
                                        space: Responsive.screenWidth(context) *
                                            0.08),
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
                                  ),
                                  Tab(
                                    text: 'Timeline',
                                  )
                                ],
                              ),
                            ),
                    ),
                    body: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : TabBarView(children: tabs),
                  );
                },
              )),
        );
      },
    );
  }
}
