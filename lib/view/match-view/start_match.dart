
import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/view/match-view/lineup.dart';

import '../../resources/utils/text_styles.dart';


class StartMatch extends StatefulWidget {
  const StartMatch({super.key});

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
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
      
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.appBarColor,
          title: const Text("Match"),
          flexibleSpace: Container(
            height: 100,
            width: 100,
            child: Text('container'),
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
        body: TabBarView(
          children: _tabs
        ),
      ),
    );
  }
}
