import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:statussaver/utilz/assets.dart';
import 'package:video_player/video_player.dart';

class FacebookVideoProvider with ChangeNotifier {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;
  bool get isInitialized => _videoPlayerController?.value.isInitialized ?? false;

  void initializeVideo(String vidPath) async {
    _videoPlayerController = VideoPlayerController.file(File(vidPath));
    await _videoPlayerController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      aspectRatio: _videoPlayerController!.value.aspectRatio, // Dynamic aspect ratio
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
        bufferedColor: Colors.white.withOpacity(0.1)
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text('Error: $errorMessage'),
        );
      },
    );

    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void disposeControllers() {
    _videoPlayerController?.pause();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    notifyListeners();
  }
}
