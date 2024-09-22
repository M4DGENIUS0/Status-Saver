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

  bool get isNotificationEnabled => _isNotificationEnabled;

  set isNotificationEnabled(bool value) {
    _isNotificationEnabled = value;
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isNotificationEnabled = _prefs?.getBool('notification_enabled') ?? false;

    if (_isNotificationEnabled) {
      _startBackgroundTask();
    }

    notifyListeners();
  }

  void toggleNotification(bool isEnabled) {
    _isNotificationEnabled = isEnabled;
    _prefs?.setBool('notification_enabled', _isNotificationEnabled);

    if (_isNotificationEnabled) {
      _startBackgroundTask();
    } else {
      _turnOffBackgroundTask();
    }

    notifyListeners();
  }

  Future<void> initialNotification(String? title, String? message) async {
    final notificationService = NotificationService();
    await notificationService.initialize();
    await notificationService.showNotification(title!, message!);
  }

  // New function to explicitly turn off notifications
  void turnOffNotification() {
    _isNotificationEnabled = false;
    _prefs?.setBool('notification_enabled', _isNotificationEnabled);
    _turnOffBackgroundTask();
    notifyListeners();
  }

  void _startBackgroundTask() {
    Workmanager().initialize(callbackDispatcher);
    Workmanager().registerPeriodicTask(
      '1',
      'checkStatusTask',
      frequency: const Duration(hours: 3),
    );
  }

  void _turnOffBackgroundTask() {
    Workmanager().cancelByTag('checkStatusTask');
  }
}
