import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/detailPageBar.dart';
import 'package:video_player/video_player.dart';

class ViewDownloadedVideoTab extends StatefulWidget {
  final String? vidPath;
  const ViewDownloadedVideoTab({super.key, this.vidPath});

  @override
  State<ViewDownloadedVideoTab> createState() => _ViewDownloadedVideoTabState();
}

class _ViewDownloadedVideoTabState extends State<ViewDownloadedVideoTab> {
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
        playedColor: assets.metaColor.withOpacity(0.5),
        handleColor: assets.metaColor,
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
                child: DetailPageBar(
                  repost: () {},
                  share: () {
                    FlutterNativeApi.shareVideo(widget.vidPath);
                  },
                )),
          ],
        ));
  }
}
