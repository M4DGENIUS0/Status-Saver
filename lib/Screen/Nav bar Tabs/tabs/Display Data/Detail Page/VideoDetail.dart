import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:statussaver/widget/detailPageBar.dart';
import 'package:video_player/video_player.dart';

class DetailVideo extends StatefulWidget {
  final String? vidPath;
  const DetailVideo({super.key, this.vidPath});

  @override
  State<DetailVideo> createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {
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
        playedColor: assets.green.withOpacity(0.5),
        handleColor: assets.green,
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
                  download: () async {
                    // Define the download directory
                    final Directory _appDocDirFolder =
                        Directory(assets.DownloadDirectory);

                    // Check if the folder exists
                    if (await _appDocDirFolder.exists()) {
                      try {
                        // Define the new path for the video in the custom folder
                        final String newVideoPath =
                            '${_appDocDirFolder.path}${DateTime.now().millisecondsSinceEpoch}.mp4';

                        // Copy the video from its current location to the custom folder
                        final File originalFile = File(widget.vidPath!);
                        final File savedFile =
                            await originalFile.copy(newVideoPath);

                        if (await savedFile.exists()) {
                          // Show a success message if the video was successfully saved
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Video saved to: ${savedFile.path}"),
                            backgroundColor: Colors.grey[800],
                          ));
                        }
                      } catch (e) {
                        // Handle any errors that occur during saving
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Error saving video: $e"),
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
        ));
  }
}
