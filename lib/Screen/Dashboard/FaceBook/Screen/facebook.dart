import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fui_kit/maps/regular_rounded.dart';
import 'package:fui_kit/widgets/icons/icon_widget.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/State%20Management/Pasteprovider.dart';
import 'package:statussaver/State%20Management/Services/FaceBook%20Service/FaceBook_Service.dart';
import 'package:statussaver/State%20Management/fbprovider.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/customtoast.dart';
// import 'package:connectivity/connectivity.dart';

class FacebookScreen extends StatefulWidget {
  const FacebookScreen({super.key});

  @override
  State<FacebookScreen> createState() => _FacebookScreenState();
}

class _FacebookScreenState extends State<FacebookScreen> {
  String name =
      'FB-${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}.mp4';
  void downloadFacebookVideo(
      BuildContext context, String facebookVideoUrl) async {
    // Create an instance of the FBservice to fetch video data
    FBservice fbService = FBservice();
    final prov = Provider.of<fbProvider>(context, listen: false);
    // Fetch the video data from the provided Facebook URL
    String? fbData = await fbService.fetchData(facebookVideoUrl);

    // Check if the fetched data contains a valid download URL
    if (fbData != null && fbData.isNotEmpty) {
      String downloadUrl = fbData;
       // Use the video URL from FBDownloader model
      prov.Downloaded();
      try {
        // Start downloading the video using FlutterDownloader
        await FlutterDownloader.enqueue(
          url: downloadUrl,
          savedDir:
              assets.DownloadDirectoryFacebook, // Ensure this directory exists
          fileName: name,
          showNotification: true, // Show notification during download
          openFileFromNotification:
              true, // Allow opening the file from the notification
        );

        // Successfully fetched and enqueued the download
        print('Video downloaded: $downloadUrl');
      } catch (e) {
        print('Error occurred during download: $e');
      }
    } else {
      prov.Downloaded();
      // If no valid URL is found, show a toast message and log it
      print('No valid video URL found.');
      showCustomToast(context, "No valid video URL found.");
    }
  }

  bool validateURL(List<String> urls) {
    // Pattern pattern = r'^(http(s)?:\/\/)?((w){3}.)?facebook?(\.com)?\/(watch\/\?v=.+|.+\/videos\/.+)$';
    String pattern = r'^(http(s)?:\/\/)?((w){3}.)?facebook?(\.com)?\/.+$';
    RegExp regex = RegExp(pattern);

    for (var url in urls) {
      if (!regex.hasMatch(url)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final pasteprovider = Provider.of<PasteProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(AppLocalizations.of(context)!.download_Facebook_Reels_Videos,
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Comfortaa',
                      color: Theme.of(context).colorScheme.onSecondary)),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.enter_FB_Videos,
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    const Gap(5),
                    InkWell(
                        onLongPress: () {
                          showCustomToast(
                              context, "Obtain URL from Facebook account");
                        },
                        onTap: () {
                          showCustomToast(
                              context, "Copy Media URL from Media you like");
                        },
                        child: FUI(
                          RegularRounded.INFO,
                          height: 15,
                          width: 15,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ))
                  ],
                ),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                readOnly: false,
                controller: pasteprovider.pasteControllerFB,
                style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.onSecondary),
                cursorColor: assets.facebook,
                enableSuggestions: false,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                    suffix: InkWell(
                        onTap: () {
                          pasteprovider.pasteControllerFB.clear();
                        },
                        child: const Icon(Icons.clear_rounded)),
                    suffixIconColor: Theme.of(context).colorScheme.onSecondary,
                    hintText: AppLocalizations.of(context)!.paste_link_here,
                    hintStyle: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.onSurface),
                    //  fillColor: Theme.of(context).colorScheme.
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: assets.facebook)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 4))),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<fbProvider>(
                  builder:
                      (BuildContext context, fbProvider value, Widget? child) {
                    return ElevatedButton(
                      onPressed: () async {
                        var connectivityResult =
                            await Connectivity().checkConnectivity();
                        if (connectivityResult == ConnectivityResult.none) {
                          showCustomToast(context, AppLocalizations.of(context)!.internet_error);
                          return;
                        } else {
                          if(pasteprovider.pasteControllerFB.text.isEmpty){
                          showCustomToast(context, "Sorry We cant proceed!");  
                          }
                          else{

                          downloadFacebookVideo(
                              context, pasteprovider.pasteControllerFB.text);
                          showCustomToast(context, AppLocalizations.of(context)!.download_Started);
                          }
                          // value.Downloaded();
                        }
                        final File video = File(name);
                        Directory dir = Directory(assets.DownloadDirectoryFacebook);
                        if(await dir.exists()){
                          if(await video.exists()){
                            // value.Downloaded();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: assets.facebook,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: value.isStarted
                          ? SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color:
                                      Theme.of(context).colorScheme.surface)) : Text(
                              AppLocalizations.of(context)!.download,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.surface),
                            )
                          ,
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    pasteprovider.pastelinkFB();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: assets.facebook,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    AppLocalizations.of(context)!.pasteIG,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
