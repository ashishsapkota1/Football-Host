import 'dart:async';

import 'package:flutter/material.dart';

class MatchTimerViewModel extends ChangeNotifier {
  late Timer _timer;
  late var _remainingTimeInSec = 0;
  var _timeOnTimer = 0;
  var _totalTimeInSec = 0;

  int get timeOnTimer => _timeOnTimer;
  int get remainingTimeInSec => _remainingTimeInSec;

  void startTimer(int matchTimeInMinutes, int matchId) async {
    _totalTimeInSec = matchTimeInMinutes * 60;
    _remainingTimeInSec = _totalTimeInSec;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_remainingTimeInSec > 0) {
        _remainingTimeInSec -= 1;
        _timeOnTimer = (_totalTimeInSec - _remainingTimeInSec) ~/ 60.ceil();
        notifyListeners();
      } else {
        _timeOnTimer = 0;
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
