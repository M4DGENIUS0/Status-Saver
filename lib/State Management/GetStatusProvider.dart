import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statussaver/utilz/assets.dart';

class StatusFetchProvider with ChangeNotifier {
  // Get Status from Storage - Ask Permission first 😊
  bool permissionGranted = true;
  bool get _permissionGranted => permissionGranted;
  List<FileSystemEntity> _getPictures = [];
  List<FileSystemEntity> get getPictures => _getPictures; 
  List<FileSystemEntity> _getVideos = [];
  List<FileSystemEntity> get getVideos => _getVideos; 
  bool _WhatsappAvailability = false;
  bool get WhatsappAvailability => _WhatsappAvailability;

  Future<void> fetchStatus(String endPoint) async {
    final requestManage = await Permission.manageExternalStorage.request();

    if (requestManage.isGranted) {
      permissionGranted = true;
      print('Granted');
      final dirPicture = Directory(assets.statusdirectory);
      if(dirPicture.existsSync()){
       final items = dirPicture.listSync();
        if(endPoint == ".jpg"){
          _getPictures = items.where((item) =>  item.path.endsWith('.jpg')).toList();
          notifyListeners();
        }
        else{
          _getVideos = items.where((item) =>  item.path.endsWith('.mp4')).toList();
          notifyListeners();

        }
        _WhatsappAvailability = true;
    notifyListeners();

      }
      else{

        print('Unable to find Directory');
      }
       
    } 
     else {
      print("Permission is restricted or limited.");
        _WhatsappAvailability = true;
    notifyListeners();

    }
  }
}
