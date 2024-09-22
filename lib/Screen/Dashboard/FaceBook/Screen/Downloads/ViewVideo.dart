import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:video_player/video_player.dart';





class ViewFBVideos extends StatefulWidget {
  final String? vidPath;
  const ViewFBVideos({super.key, this.vidPath});

  @override
  State<ViewFBVideos> createState() => _ViewFBVideosState();
}

class _ViewFBVideosState extends State<ViewFBVideos> {
  ChewieController? _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(File(widget.vidPath!)),
      aspectRatio: 9 / 16,
      looping: false,
      showControlsOnInitialize: true,
      autoPlay: true,
      autoInitialize: true,
      allowFullScreen: false,
      allowMuting: true,
      showControls: true,
      allowPlaybackSpeedChanging: false,
      allowedScreenSleep: true,
      controlsSafeAreaMinimum: const EdgeInsets.all(9),
      draggableProgressBar: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: assets.facebook.withOpacity(0.5),
        handleColor: assets.facebook,
        backgroundColor: Colors.black,
        bufferedColor: Colors.white.withOpacity(0.1),
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text('Error: $errorMessage'),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();
  }

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
          children: [
            SizedBox(
                height: 600,
                child: Chewie(
                  controller: _chewieController!,
                )),
            const SizedBox(
              height: 20,
            ),
             Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.vidPath != null) {
                        File data = File(widget.vidPath!);
                        data.delete();
                        Future.delayed(Duration(seconds: 2)).then((v) {
                          Navigator.pop(context);
                        });
                      data.delete();
                      }
                      
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          "Delete",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Column(
                      children: [
                        Icon(
                          Icons.download_done_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          "Saved",
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
                      FlutterNativeApi.shareImage(widget.vidPath);
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
        ));
  }
}
