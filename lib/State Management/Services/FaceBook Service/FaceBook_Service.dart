import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:statussaver/State%20Management/Services/FaceBook%20Service/fb_model.dart';

class FBservice {
  Future<String?> fetchData(String facebookVideoUrl) async {
    final url = "https://facebook-reel-and-video-downloader.p.rapidapi.com/app/main.php?url=$facebookVideoUrl";
    
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-RapidAPI-Key': 'd02f498529msh0f9fee89c8a6c15p146328jsn20b45d7fe16c', // Replace with your RapidAPI key
          'X-RapidAPI-Host': 'facebook-reel-and-video-downloader.p.rapidapi.com'
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = FBDownloader.fromJson(json); // Map response to FBDownloader model
        return data.links!.downloadHighQuality!;
      } else {
        print('Failed to load video info. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}
