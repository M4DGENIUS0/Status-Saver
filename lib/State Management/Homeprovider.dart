import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
   Selectedvalue(int value) {
    selectedindex = value;
    notifyListeners();
  }

  BottomSheetradio(String value){
    index = value;
    notifyListeners();
  }
}
