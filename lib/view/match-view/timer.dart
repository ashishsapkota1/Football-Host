import 'dart:async';

import 'package:flutter/material.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';
import 'package:provider/provider.dart';

class MatchTimer extends StatefulWidget {
  const MatchTimer({super.key});

  @override
  State<MatchTimer> createState() => _MatchTimerState();
}

class _MatchTimerState extends State<MatchTimer> {


  int _remainingTimeInSec = 0;




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final matchViewModel = Provider.of<MatchViewModel>(context, listen: false);
    int matchTime = matchViewModel.matchTime;
    return Text(matchTime.toString());
  }
}
