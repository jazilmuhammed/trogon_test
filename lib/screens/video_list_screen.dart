import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trogon_test/provider/video_list_screen_provider.dart';
import 'package:trogon_test/screens/vimeo_player_screen.dart';
import 'package:trogon_test/screens/youtube_player_screen.dart';
import 'package:trogon_test/shared/colors.dart';

class VideoListScreen extends StatefulWidget {
  final String moduleId;

  const VideoListScreen({super.key, required this.moduleId});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  @override
  @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<VideoProvider>(context, listen: false).fetchVideos(widget.moduleId);
  });
}


  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoProvider>(context);
    final videoList = videoProvider.videos;

    return Scaffold(
      appBar: AppBar(title: const Text("Video Lessons"), centerTitle: true),
      body: videoProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                final video = videoList[index];
                return InkWell(
                  onTap: () {
                    if (video.videoType?.toLowerCase() == "youtube") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              YouTubePlayerScreen(videoUrl: video.videoUrl!),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VimeoPlayerScreen(videoUrl: video.videoUrl!),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Container(
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorClass.getRandomColor(),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.play_circle_fill,
                              size: 60, color: Colors.redAccent),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(video.title ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(video.description ?? '',
                                    maxLines: 2, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
