import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';

class ViewDownloadedPicture extends StatelessWidget {
  final String imgPath;
  const ViewDownloadedPicture({super.key, required this.imgPath});

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
            height: 10,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Column(
                      children: [
                        Icon(
                          Icons.repeat_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          "Repost",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FlutterNativeApi.shareImage(imgPath);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
