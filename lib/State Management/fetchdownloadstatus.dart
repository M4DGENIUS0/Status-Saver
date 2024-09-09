import 'dart:io';

import 'package:flutter/material.dart';
import 'package:statussaver/utilz/assets.dart';

class FetchDownloadStatus with ChangeNotifier {
  List<FileSystemEntity> _getPictures = [];
  List<FileSystemEntity> get getPictures => _getPictures;
  List<FileSystemEntity> _getVideos = [];
  List<FileSystemEntity> get getVideos => _getVideos;
  bool _Downloaded = false;
  bool get Downloaded => _Downloaded;

  Future<String> createFolderInAppDocDir(String filename) async {
    final Directory appDocDirFolder = Directory(assets.DownloadDirectory);

    if (await appDocDirFolder.exists()) {
      if (appDocDirFolder.existsSync()) {
        final items = appDocDirFolder.listSync();
        if (filename == ".jpg") {
          _getPictures =
              items.where((item) => item.path.endsWith('.jpg')).toList();
          notifyListeners();
        } else {
          _getVideos =
              items.where((item) => item.path.endsWith('.mp4')).toList();
          notifyListeners();
        }
        _Downloaded = true;
        notifyListeners();
      }
      notifyListeners();
      return appDocDirFolder.path;
    } else {
      try {
        final Directory _appDocDirNewFolder =
            await appDocDirFolder.create(recursive: true);
        _Downloaded = true;
        notifyListeners();
        return _appDocDirNewFolder.path;
      } catch (e) {
        _Downloaded = false;
        notifyListeners();
        throw Exception("Failed to create folder: $e");
      }
    }
  }
}
