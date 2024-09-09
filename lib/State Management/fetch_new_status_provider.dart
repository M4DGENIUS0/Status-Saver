import 'package:flutter/material.dart';
import 'package:statussaver/State%20Management/background%20service/background_task.dart';
import 'package:workmanager/workmanager.dart';

class StatusProvider with ChangeNotifier {
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  void toggleNotification(bool isEnabled) {
    _isNotificationEnabled = isEnabled;
    if (_isNotificationEnabled) {
      Workmanager().initialize(callbackDispatcher);
      Workmanager().registerPeriodicTask(
        '1',
        'checkStatusTask',
        frequency: Duration(minutes: 15),
      );
    } else {
      Workmanager().cancelByTag('checkStatusTask');
    }
    notifyListeners();
  }
}
