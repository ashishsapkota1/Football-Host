
import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/arg.dart';
import 'package:football_host/view/match-view/lineup.dart';

import '../../resources/utils/text_styles.dart';


class StartMatch extends StatefulWidget {
  final int? team1Id;
  final String? team1Name;
  final int? team2Id;
  final String? team2Name;
  const StartMatch({super.key, required this.team1Id, required this.team2Id, required this.team1Name, required this.team2Name});

  @override
  State<StartMatch> createState() => _StartMatchState();
}

class _StartMatchState extends State<StartMatch> with TickerProviderStateMixin{

  final List<Widget> _tabs = [
    LineUp()

  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {

    print(widget.team1Id);
    print(widget.team2Id);

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
      
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.appBarColor,
          title:  Text("${widget.team1Name} vs ${widget.team2Name}"),
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
        body: TabBarView(
          children: _tabs
        ),
      ),
    );
  }
}
