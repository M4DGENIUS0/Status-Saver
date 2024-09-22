import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:io';
import 'package:statussaver/utilz/assets.dart';

class FlutterInsta with ChangeNotifier {
  String url = "https://www.instagram.com/";

  // Download reels video
  Future<String?> downloadReels(String link) async {
    final Directory instaDownloadPath = Directory(assets.DownloadDirectoryInstagram);

    // Check if the directory exists
    if (!await instaDownloadPath.exists()) {
      try {
        final Directory newFolder = await instaDownloadPath.create(recursive: true);
        notifyListeners();
        print('Created new directory at: ${newFolder.path}');
      } catch (e) {
        notifyListeners();
        throw Exception("Failed to create folder: $e");
      }
    }

    try {
      link = link.trim();
      if (!link.endsWith("/")) {
        link += "/";
      }

      var linkParts = link.split("/");
      if (linkParts.length < 5) {
        print('Invalid link structure');
        return null; // Return early if link structure is invalid
      }

      var url = '${linkParts[0]}//${linkParts[2]}/${linkParts[3]}/${linkParts[4]}?__a=1&__d=dis';

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data.containsKey('graphql') &&
            data['graphql'].containsKey('shortcode_media')) {
          var shortcodeMedia = data['graphql']['shortcode_media'];
          if (shortcodeMedia.containsKey('video_url')) {
            var videoUrl = shortcodeMedia['video_url'];

            // Use a shortened file name or a custom one
            var fileName = "${DateTime.now().millisecondsSinceEpoch}.mp4"; // Custom shorter file name

            // Initiating download using flutter_downloader
            print("Starting download for video at: $videoUrl");
            print("Download directory: ${instaDownloadPath.path}");

            await FlutterDownloader.enqueue(
              url: videoUrl,
              savedDir: instaDownloadPath.path,
              fileName: fileName,
              showNotification: true,
              openFileFromNotification: true,
            ).then((taskId) {
              print("Download task ID: $taskId");
            }).catchError((error) {
              print("Download failed: $error");
            });
           

            return videoUrl;
            
          } else {
            print('Video URL not found in the response');
            return null;
          }
        } else {
          print('Invalid response structure');
          return null;
        }
      } else {
        print('Failed to load data from Instagram');
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print("Error downloading reels: $e");
      return null; // Return null on error
    }
  }
}
