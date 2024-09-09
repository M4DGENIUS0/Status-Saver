import 'package:statussaver/State%20Management/Services/notification_service.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:io';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final notificationService = NotificationService();
    await notificationService.initialize();

    const dirPath = assets.statusdirectory;
    final dir = Directory(dirPath);

    if (dir.existsSync()) {
      final items = dir.listSync();
      // Check for new statuses and notify if found
      final newStatuses =
          items.where((item) => item is File && item.path.endsWith('.jpg'));
      print('Directory exists. Total items: ${items.length}');
      print('New statuses found: ${newStatuses.length}');
      if (newStatuses.isNotEmpty) {
        notificationService.showNotification(
          'New Status',
          'New WhatsApp statuses are available!',
        );
      }
    }

    return Future.value(true);
  });
}
