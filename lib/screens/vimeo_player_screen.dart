import 'package:flutter/material.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class VimeoPlayerScreen extends StatelessWidget {
  final String videoUrl; 

  const VimeoPlayerScreen({super.key, required this.videoUrl});

  /// Extracts the video ID from the Vimeo URL.
  String extractVimeoId(String url) {
    final uri = Uri.parse(url);
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
  }

  @override
  Widget build(BuildContext context) {
    final videoId = extractVimeoId(videoUrl);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vimeo Player"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: VimeoVideoPlayer(
        videoId: videoId, // Pass the extracted video ID
        isAutoPlay: true,
      ),
    );
  }
}
