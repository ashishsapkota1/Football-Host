import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier{
  bool isTapped = false;

  void onTapped(){
    isTapped = !isTapped;
    notifyListeners();
  }

  void resetTapped(){
    isTapped = false;
    notifyListeners();
  }

}