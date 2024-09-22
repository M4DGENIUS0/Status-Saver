import 'dart:io';

import 'package:flutter/material.dart';
import 'package:statussaver/utilz/assets.dart';

class FetchIGDownload with ChangeNotifier {
  List<FileSystemEntity> _getVideos = [];
  List<FileSystemEntity> get getVideos => _getVideos;
  bool _Downloaded = false;
  bool get Downloaded => _Downloaded;

  Future<String> createFolderInAppDocDir() async {
    final Directory appDocDirFolder = Directory(assets.DownloadDirectoryInstagram);
    if (await appDocDirFolder.exists()) {
      if (appDocDirFolder.existsSync()) {
        final items = appDocDirFolder.listSync();
        
          _getVideos =
              items.where((item) => item.path.endsWith('.mp4')).toList();
          notifyListeners();
        
        _Downloaded = true;
        notifyListeners();
      }
      notifyListeners();
      return appDocDirFolder.path;

    } else {
      try {
        final Directory appDocDirNewFolder =
            await appDocDirFolder.create(recursive: true);
        _Downloaded = true;
        notifyListeners();
        return appDocDirNewFolder.path;
      } catch (e) {
        _Downloaded = false;
        notifyListeners();
        throw Exception("Failed to create folder: $e");
      }
    }
  }
}
