import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statussaver/Screen/Dashboard/Download%20Tab/Download%20Data/Download%20Display/DownloadedPictures.dart';
import 'package:statussaver/Screen/Dashboard/Download%20Tab/Download%20Data/Download%20Display/DownloadedVideos.dart';
import 'package:statussaver/Screen/Dashboard/home.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/Setting.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Display%20Data/Display%20GridView/DisplayPictures.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Display%20Data/Display%20GridView/DisplayVideos.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Download/Download%20Data/Download%20Display/DownloadedPictures.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Download/Download%20Data/Download%20Display/DownloadedVideos.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Download/Empty%20Download/Pictures.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Download/Empty%20Download/Videos.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Permission%20Screen/photoPermission.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Permission%20Screen/videoPermisson.dart';

class assets {
  static const Color green = Color.fromRGBO(0, 128, 0, 1); 
  static const Color instgramColor1 = Color.fromRGBO(248, 11, 40, 1);
  static const Color instgramColor2 = Color.fromRGBO(225, 4, 146, 1);
  static const Color instgramColor3 = Color.fromRGBO(252, 81, 4, 1);
  static const Color instgramColor4 = Color.fromRGBO(252, 162, 4, 1);
  static const Color facebook = Color.fromRGBO(28, 116, 212, 1);
  static const Color metaColor = Color.fromRGBO(	0, 129, 251, 1);
  static const whatsapp = 'assets/images/whatsapp.png';
  static const whatsappBusiness = 'assets/images/whatsapp-business.png';
  static const crown = 'assets/images/crown.png';
  static const notification = 'assets/images/notification.png';
  static const whatsappGB = 'assets/images/whatsappGB.png';
  static const Facebook = 'assets/images/facebook.png';
  static const Instagram = 'assets/images/instagram.png';
  static const metamedia = 'assets/images/metamedia.png';

  static const statusdirectory = '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/';
  static const DownloadDirectory = '/storage/emulated/0/DCIM/Story Saver/';
  // Method to check storage permission
  static Stream<List<Widget>> getWhatsappTabbTabItems() async* {
    bool isStorageGranted = await Permission.manageExternalStorage.isGranted;
    
    if (isStorageGranted) {
      yield [
        const TabBarView(
          children: [
            Displaypictures(),
            Displayvideos(),
          ],
        ),
        const TabBarView(
          children: [
            DownloadedPictureDisplay(),
            DownloadedVideoDisplay(),
          ],
        ),
        // Setting(),
      ];
    } else {
      yield [
        const TabBarView(
          children: [
            StatusPicturePermission(),
            StatusVideoPermission(),
          ],
        ),
        const TabBarView(
          children: [
            EmptyBucketPictures(),
            EmptyBucketVideos(),
          ],
        ),
        // Setting(),
      ];
    }
  }


  static Stream<List<Widget>> getHomeTabItems() async* {
    bool isStorageGranted = await Permission.manageExternalStorage.isGranted;
    
    if (isStorageGranted) {
      yield [
        const Home(),
        const TabBarView(
          children: [
            DownloadedPictureTab(),
            DownloadedVideoTab(),
          ],
        ),
        const Setting(),
      ];
    } else {
      yield [
        const Home(),
        const TabBarView(
          children: [
            EmptyBucketPictures(),
            EmptyBucketVideos(),
          ],
        ),
        const Setting(),
      ];
    }
  }

}
