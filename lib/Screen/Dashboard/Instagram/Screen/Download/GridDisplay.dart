import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:statussaver/Screen/Dashboard/Instagram/Screen/Download/reelvideoplayer.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Download/Empty%20Download/Videos.dart';
import 'package:statussaver/State%20Management/FetchIGDownloadeds.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/videothumbnaik.dart';

class DownloadedReels extends StatelessWidget {
  const DownloadedReels({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFetch = false;
    return Consumer<FetchIGDownload>(
      builder: (BuildContext context, value, Widget? child) {
        if (isFetch == false) {
          value.createFolderInAppDocDir();
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
                  color: assets.instgramColor2,
                  onRefresh: () async {
                    Future.delayed(const Duration(seconds: 5));
                    value.createFolderInAppDocDir();
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
                                              child: PlayDownloadedReels(
                                                  vidPath: data.path),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                    File(snapshot.data!)))),
                                      ),
                                      Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: Icon(
                                              Icons.download_done_rounded,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface))
                                    ]),
                                  )
                                : Shimmer(
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: assets.instgramColor2
                                            .withOpacity(0.2),
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
