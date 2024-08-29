import 'package:flutter/material.dart';

class Direct_Chat with ChangeNotifier {
  String _formattedNumber = '';

  String get formattedNumber => _formattedNumber;

   updatePhoneNumber(String phoneNumber) {
    // Remove the "+" sign if it exists
    _formattedNumber = phoneNumber.replaceAll(RegExp(r'^\+'), '');
    notifyListeners();
  }
}
