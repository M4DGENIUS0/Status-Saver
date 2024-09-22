import 'package:flutter/material.dart';

class InstaProvider with ChangeNotifier{
  bool downloading = false;
  bool get _downloading => downloading;
  void downloaded(bool downloaded){
    downloading = !downloading;
    notifyListeners();
  }
}