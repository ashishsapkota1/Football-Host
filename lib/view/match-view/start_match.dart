
import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/view/match-view/lineup.dart';

import '../../resources/utils/responsive.dart';

class StartMatch extends StatefulWidget {
  const StartMatch({super.key});

  @override
  State<StartMatch> createState() => _StartMatchState();
}

class _StartMatchState extends State<StartMatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBarColor,
      appBar: AppBar(),
      body:  const Column(
        children: [
          LineUp(qTurns: 4,),
          LineUp(qTurns: 2)

        ],
      )
    );
  }
}
