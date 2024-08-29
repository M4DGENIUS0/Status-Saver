import 'package:flutter/material.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/Setting.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Download/Empty%20Download/Pictures.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Download/Empty%20Download/Videos.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Permission%20Screen/photoPermission.dart';
import 'package:statussaver/Screen/Nav%20bar%20Tabs/tabs/Permission%20Screen/videoPermisson.dart';

class assets{
  static const Color green = Color.fromRGBO(0, 128, 0, 1); 

  static const whatsapp = 'assets/images/whatsapp.png';
  static const whatsappBusiness = 'assets/images/whatsapp-business.png';
  static const crown = 'assets/images/crown.png';
  static const notification = 'assets/images/notification.png';
  static const whatsappGB = 'assets/images/whatsappGB.png';


  static const List<Widget> tabItems = [
    TabBarView(children: [
        StatusPicturePermission(),
        StatusVideoPermission()

        ],),
        TabBarView(children: [
        EmptyBucketPictures(),
        EmptyBucketVideos()

        ],),
    Setting()
  ];

  
}