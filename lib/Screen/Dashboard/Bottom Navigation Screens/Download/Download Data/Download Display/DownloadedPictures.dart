import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/Screen/Dashboard/Bottom%20Navigation%20Screens/Download/Download%20Data/View%20Download/PictureView.dart';
import 'package:statussaver/Screen/Dashboard/Whatsapp/tabs/Download/Empty%20Download/Pictures.dart';
import 'package:statussaver/State%20Management/fetchdownloadstatus.dart';
import 'package:statussaver/utilz/assets.dart';

class DownloadedPictureTab extends StatelessWidget {
  const DownloadedPictureTab({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFetch = false;
    return Consumer<FetchDownloadStatus>(
      builder: (BuildContext context, value, Widget? child) {
        if (isFetch == false) {
          value.createFolderInAppDocDir('.jpg');
          Future.delayed(const Duration(microseconds: 1), () {
            isFetch = true;
          });
        }
        return value.getPictures.isEmpty
            ? const Center(child: EmptyBucketPictures())
            : Padding(
                padding: const EdgeInsets.all(20),
                child: RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  color: assets.metaColor,
                  onRefresh: () async {
                    Future.delayed(const Duration(seconds: 5));
                    value.createFolderInAppDocDir('.jpg');
                  },
                  child: GridView(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      children:
                          List.generate(value.getPictures.length, (index) {
                        final data = value.getPictures[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                    milliseconds:
                                        200), // Set slow transition duration
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: ViewDownloadedPictureTab(
                                        imgPath: data.path),
                                  );
                                },
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'picture $data',
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(data.path)))),
                            ),
                          ),
                        );
                      })),
                ),
              );
      },
    );
  }
}
