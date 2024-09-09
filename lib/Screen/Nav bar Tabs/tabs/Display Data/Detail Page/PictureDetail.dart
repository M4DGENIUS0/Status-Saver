import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/detailPageBar.dart';

class DetailPhoto extends StatelessWidget {
  final String imgPath;
  const DetailPhoto({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Hero(
            tag: 'picture ${imgPath}',
            flightShuttleBuilder:
                (flightContext, animation, direction, fromContext, toContext) {
              return ScaleTransition(
                scale: animation.drive(
                  Tween<double>(begin: 1.8, end: 1.0).chain(
                    CurveTween(
                        curve: Curves
                            .linearToEaseOut), // Customize the curve for smoothness
                  ),
                ),
                child: toContext.widget,
              );
            },
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.7,
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      fit: BoxFit.contain, image: FileImage(File(imgPath)))),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: DetailPageBar(
                repost: () {},
                share: () {
                  FlutterNativeApi.shareImage(imgPath);
                },
                download: () async {
                  // Define the download directory
                  final Directory _appDocDirFolder =
                      Directory(assets.DownloadDirectory);

                  // Check if the folder exists
                  if (await _appDocDirFolder.exists()) {
                    try {
                      final String newPicturePath =
                          '${_appDocDirFolder.path}${DateTime.now().millisecondsSinceEpoch}.jpg';

                      // Copy the Picturreee from its current location to the custom folder
                      final File originalFile = File(imgPath);
                      final File savedFile =
                          await originalFile.copy(newPicturePath);

                      if (await savedFile.exists()) {
                        // Success message if the video was successfully saved
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Picture saved to: ${savedFile.path}"),
                          backgroundColor: Colors.grey[800],
                        ));
                      }
                    } catch (e) {
                      //  errors that occur during saving
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error saving Picture: $e"),
                        backgroundColor: Colors.grey[800],
                      ));
                    }
                  } else {
                    // If the folder doesn't exist, show an error message
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                          "Could not download, folder does not exist"),
                      backgroundColor: Colors.grey[800],
                    ));
                  }
                },
              )),
        ],
      ),
    );
  }
}
