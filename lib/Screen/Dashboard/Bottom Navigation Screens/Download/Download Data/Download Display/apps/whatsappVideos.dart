import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:statussaver/Screen/Dashboard/Bottom%20Navigation%20Screens/Download/Download%20Data/View%20Download/VideoView.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Download/Empty%20Download/Videos.dart';
import 'package:statussaver/State%20Management/fetchdownloadstatus.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/videothumbnaik.dart';

class WhatsappVid extends StatelessWidget {
  const WhatsappVid({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFetch = false;
    return Consumer<FetchDownloadStatus>(
      builder: (BuildContext context, value, Widget? child) {
        if (isFetch == false) {
          value.createFolderInAppDocDir('.mp4');
          Future.delayed(const Duration(microseconds: 1), () {
            isFetch = true;
          });
        }
        return value.getVideos.isEmpty
            ? const Center(
                child: EmptyBucketVideos(),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  color: assets.metaColor,
                  onRefresh: () async {
                    Future.delayed(const Duration(seconds: 5));
                    value.createFolderInAppDocDir('.mp4');
                  },
                  child: GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      children: List.generate(value.getVideos.length, (index) {
                        final data = value.getVideos[index];
                        return FutureBuilder<String>(
                          future: getThumbnail(data.path),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            return snapshot.hasData
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: const Duration(
                                              milliseconds:
                                                  200), // Set slow transition duration
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: ViewDownloadedVideoTab(
                                                  vidPath: data.path),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                  File(snapshot.data!)))),
                                    ),
                                  )
                                : Shimmer(
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            assets.metaColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  );
                          },
                        );
                      })),
                ),
              );
      },
    );
  }
}
