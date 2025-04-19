import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/video_model.dart';

class VideoProvider extends ChangeNotifier {
  List<VideoModel> _videos = [];
  bool _isLoading = false;

  List<VideoModel> get videos => _videos;
  bool get isLoading => _isLoading;

  Future<void> fetchVideos(String moduleId) async {
    _isLoading = true;
    notifyListeners();

    const String url = 'https://trogon.info/interview/php/api/videos.php?module_id=1';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _videos = videoModelFromJson(response.body);
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      debugPrint('Video fetch error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
