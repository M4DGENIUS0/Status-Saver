import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  String? _selectedValue;
  String? get selectedValue => _selectedValue;
  
  int selectedindex = 0;
int get _selectedindex => selectedindex;

  String index = ''; // Custom Radio button for bottom sheet
String get _index => index;


  void selectValue(String value) {
    _selectedValue = value;
    notifyListeners();
  }
   // ignore: non_constant_identifier_names
   Selectedvalue(int value) {
    selectedindex = value;
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  BottomSheetradio(String value){
    index = value;
    notifyListeners();
  }
}
