import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statussaver/Screen/Dashboard/Bottom%20Navigation%20Screens/Download/Download%20Data/Download%20Display/DownloadedPictures.dart';
import 'package:statussaver/Screen/Dashboard/Bottom%20Navigation%20Screens/Download/Download%20Data/Download%20Display/apps/InstagramVideos.dart';
import 'package:statussaver/Screen/Dashboard/Bottom%20Navigation%20Screens/Download/Download%20Data/Download%20Display/apps/facebookVideos.dart';
import 'package:statussaver/Screen/Dashboard/Bottom%20Navigation%20Screens/Download/Download%20Data/Download%20Display/apps/whatsappVideos.dart';
import 'package:statussaver/Screen/Dashboard/FaceBook/Screen/Downloads/DisplayfbGrids.dart';
import 'package:statussaver/Screen/Dashboard/FaceBook/Screen/facebook.dart';
import 'package:statussaver/Screen/Dashboard/Instagram/Screen/Download/GridDisplay.dart';
import 'package:statussaver/Screen/Dashboard/Instagram/Screen/Tab%20Bar/Instagram.dart';
import 'package:statussaver/Screen/Dashboard/Instagram/Screen/Tab%20Bar/Stories.dart';
import 'package:statussaver/Screen/Dashboard/Bottom%20Navigation%20Screens/home.dart';
import 'package:statussaver/Screen/Dashboard/Bottom%20Navigation%20Screens/Setting.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Display%20Data/Display%20GridView/DisplayPictures.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Display%20Data/Display%20GridView/DisplayVideos.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Download/Download%20Data/Download%20Display/DownloadedPictures.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Download/Download%20Data/Download%20Display/DownloadedVideos.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Download/Empty%20Download/Pictures.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Download/Empty%20Download/Videos.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Permission%20Screen/photoPermission.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Permission%20Screen/videoPermisson.dart';

class assets {
  static const Color green = Color.fromRGBO(0, 128, 0, 1);
  static const Color instgramColor1 = Color.fromRGBO(248, 11, 40, 1);
  static const Color instgramColor2 = Color.fromRGBO(225, 4, 146, 1);
  static const Color instgramColor3 = Color.fromRGBO(252, 81, 4, 1);
  static const Color instgramColor4 = Color.fromRGBO(252, 162, 4, 1);
  static const Color facebook = Color.fromRGBO(28, 116, 212, 1);
  static const Color metaColor = Color.fromRGBO(0, 129, 251, 1);
  static const whatsapp = 'assets/images/whatsapp.png';
  static const whatsappBusiness = 'assets/images/whatsapp-business.png';
  static const crown = 'assets/images/crown.png';
  static const notification = 'assets/images/notification.png';
  static const whatsappGB = 'assets/images/whatsappGB.png';
  static const Facebook = 'assets/images/facebook.png';
  static const fb = 'assets/images/facebook-app.png';
  // ----------------------------------------------------
  //HTD (How To Do)
  // Whatsapp 
  static const whatsapp1 = "assets/images/HTD/Whatsapp/whatsapp1.jpg";
  static const whatsapp2 = "assets/images/HTD/Whatsapp/whatsapp2.jpg";
  //Instagram
  static const IG1 = "assets/images/HTD/Instagram/IG1.jpg";
  static const IG2 = "assets/images/HTD/Instagram/IG2.jpg";
  static const IG3 = "assets/images/HTD/Instagram/IG3.jpg";
  static const IG4 = "assets/images/HTD/Instagram/IG4.jpg";
  static const IG5 = "assets/images/HTD/Instagram/IG5.jpg";
  static const IG6 = "assets/images/HTD/Instagram/IG6.jpg";
  static const IG7 = "assets/images/HTD/Instagram/IG7.jpg";
  //Facebook
  static const fb1 = "assets/images/HTD/Facebook/fb1.jpg";
  static const fb2 = "assets/images/HTD/Facebook/fb2.jpg";
  static const fb3 = "assets/images/HTD/Facebook/fb3.jpg";
  static const fb4 = "assets/images/HTD/Facebook/fb4.jpg";
  static const fb5 = "assets/images/HTD/Facebook/fb5.jpg";
  static const fb6 = "assets/images/HTD/Facebook/fb6.jpg";
  static const fb7 = "assets/images/HTD/Facebook/fb7.jpg";


  //  list
  
  // ----------------------------------------------------

  static const Instagram = 'assets/images/instagram.png';
  static const metamedia = 'assets/images/metamedia.png';

  static const statusdirectory =
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/';
  static const DownloadDirectoryWhatsapp = '/storage/emulated/0/DCIM/Whatsapp Saver';
  static const DownloadDirectoryInstagram =
      '/storage/emulated/0/DCIM/Instagram Saver';
  static const DownloadDirectoryFacebook =
      '/storage/emulated/0/DCIM/FaceBook Saver';

  


  // Whatsapp
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
      ];
    }
  }

  //Instagram Bottom Navigation Tabs Here Below:
  // ignore: non_constant_identifier_names
  static Stream<List<Widget>> InstagramBotmNavsTab() async* {
    bool isStorageGranted = await Permission.manageExternalStorage.isGranted;

    if (isStorageGranted) {
      yield [
        const TabBarView(
          children: [
            InstagramScreen(),
            Stories(),
          ],
        ),
        const DownloadedReels(),
      ];
    } else {
      yield [
        const TabBarView(
          children: [
            InstagramScreen(),
            Stories(),
          ],
        ),
        const EmptyBucketVideos(),
      ];
    }
  }

  //FaceBook Bottom Navigation
  static Stream<List<Widget>> FBBotmNavsTab() async* {
    bool isStorageGranted = await Permission.manageExternalStorage.isGranted;

    if (isStorageGranted) {
      yield [
        const FacebookScreen(),
        const DownloadedFBReels(),
      ];
    } else {
      yield [
        const FacebookScreen(),
        const EmptyBucketVideos(),
      ];
    }
  }

  //Main Home Bottom Navigation
  static Stream<List<Widget>> getHomeTabItems() async* {
    bool isStorageGranted = await Permission.manageExternalStorage.isGranted;

    if (isStorageGranted) {
      yield [
        const Home(),
        const TabBarView(
          children: [
            DownloadedPictureTab(),
            WhatsappVid(),
            InstagramVideos(),
            facebookVideos()
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
            EmptyBucketVideos(),
            EmptyBucketVideos(),

          ],
        ),
        const Setting(),
      ];
    }
  }
}
