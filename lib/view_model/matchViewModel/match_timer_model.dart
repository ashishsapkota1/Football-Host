import 'dart:async';

import 'package:flutter/material.dart';

class MatchTimerViewModel extends ChangeNotifier {
  late Timer _timer;
  var _remainingTimeInSec = 0;
  var _timeOnTimer = 0;

  int get timeOnTimer => _timeOnTimer;

  void startTimer(int matchTimeInMinutes, int matchId) async {
    _remainingTimeInSec = matchTimeInMinutes * 60; // Convert minutes to seconds

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_remainingTimeInSec > 0) {
        var currentTime = _remainingTimeInSec -= 1;
        if (currentTime != _timeOnTimer) {
          _timeOnTimer = (currentTime / 60).ceil();
          notifyListeners();
        }
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
