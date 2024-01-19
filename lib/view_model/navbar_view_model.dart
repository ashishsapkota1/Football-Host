import 'package:flutter/material.dart';

class NavbarViewModel extends ChangeNotifier{
  int _selectedItem= 0;
  get selectedItem => _selectedItem;

  set setSelectedItem(int index){
    _selectedItem = index;
    notifyListeners();

  }

}