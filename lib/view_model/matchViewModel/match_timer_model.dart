import 'dart:async';
import 'package:flutter/material.dart';

class MatchTimerViewModel extends ChangeNotifier {
  late Timer _timer;
  var _remainingTimeInSec = 0;

  void startTimer(int matchTimeInMinutes) {
    _remainingTimeInSec = matchTimeInMinutes * 60; // Convert minutes to seconds

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTimeInSec > 0) {
        _remainingTimeInSec -= 1;
      } else {
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
