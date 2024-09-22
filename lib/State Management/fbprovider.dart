import 'package:flutter/material.dart';

class fbProvider with ChangeNotifier{
  bool isStarted = false;
  bool get _isStarted => isStarted;


  void Downloaded(){
    isStarted = !isStarted;
    notifyListeners();
  }
}