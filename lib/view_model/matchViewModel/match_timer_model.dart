import 'dart:async';
import 'package:flutter/material.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';

class MatchTimerViewModel extends ChangeNotifier {
  late Timer _timer;
  var _remainingTimeInSec = 0;
  var _timeOnTimer = 0;
  final MatchViewModel matchViewModel = MatchViewModel();

  int get timeOnTimer => _timeOnTimer;

  void startTimer(int matchTimeInMinutes, int matchId) async {
    matchViewModel.getFirstHalf(matchId);
    matchViewModel.getSecondHalf(matchId);
    _remainingTimeInSec = matchTimeInMinutes * 60; // Convert minutes to seconds

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_remainingTimeInSec > 0) {
        var currentTime = _remainingTimeInSec -= 1;
        if (currentTime != _timeOnTimer) {
          _timeOnTimer = (currentTime / 60).ceil();
          notifyListeners();
        }
      } else {
        if (matchViewModel.isFirstHalf == false &&
            matchViewModel.isSecondHalf == false) {
          matchViewModel.firstHalf(matchId, true);
        } else if (matchViewModel.isFirstHalf == true &&
            matchViewModel.isSecondHalf == false) {
          matchViewModel.secondHalf(matchId, true);
        }
        matchViewModel.matchStarted(matchId, false);
        timer.cancel();
      }
      notifyListeners();
    });
  }

  String get remainingTime {
    var minutes = _remainingTimeInSec ~/ 60;
    var seconds = _remainingTimeInSec % 60;
    return '$minutes : ${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
