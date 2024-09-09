import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statussaver/State%20Management/Services/notification_service.dart';
import 'package:statussaver/State%20Management/background%20service/background_task.dart';
import 'package:workmanager/workmanager.dart';

class StatusNotifyProvider with ChangeNotifier {
  bool _isNotificationEnabled = false;
  SharedPreferences? _prefs;

  StatusNotifyProvider() {
    _loadPreferences();
  }
set isNotificationEnabled(bool value) {

    _isNotificationEnabled = value;

    notifyListeners();

  }
  bool get isNotificationEnabled => _isNotificationEnabled;

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isNotificationEnabled = _prefs?.getBool('notification_enabled') ?? false;
    if (_isNotificationEnabled) {
      Workmanager().initialize(callbackDispatcher);
      Workmanager().registerPeriodicTask(
        '1',
        'checkStatusTask',
        frequency: Duration(minutes: 15),
      );
    }
    notifyListeners();
  }

  void toggleNotification(bool isEnabled) {
    _isNotificationEnabled = isEnabled;
    _prefs?.setBool('notification_enabled', _isNotificationEnabled);

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

  Future<void> initialNotification(String? title, String? message) async {
    final notificationService = NotificationService();
    await notificationService.initialize();
    await notificationService.showNotification(title!, message!);
  }
}
