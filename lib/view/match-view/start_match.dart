import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/responsive.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/view/match-view/lineup.dart';
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

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      LineUp(team1Id: widget.matches.team1Id, team2Id: widget.matches.team2Id)
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
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
                    widget.matches.team1Score.toString(),
                    style: TextStyles.scoreStyle,
                  ),
                  verticalSpacing(space: Responsive.screenWidth(context) * 0.04),
                  const Text('-',style: TextStyles.scoreStyle,),
                  verticalSpacing(space: Responsive.screenWidth(context) * 0.04),
                  Text(
                    widget.matches.team2Score.toString(),
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
              controller: _tabController,
              labelStyle: TextStyles.tabBarStyle,
              tabs: const [
                Tab(
                  text: 'Playing 11',
                ),
                Tab(
                  text: 'Formation',
                ),
                Tab(
                  text: 'LineUp',
                )
              ],
            ),
          ),
        ),
        body: TabBarView(children: tabs),
      ),
    );
  }
}
