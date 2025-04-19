// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

List<VideoModel> videoModelFromJson(String str) => List<VideoModel>.from(json.decode(str).map((x) => VideoModel.fromJson(x)));

String videoModelToJson(List<VideoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoModel {
    int? id;
    String? title;
    String? description;
    String? videoType;
    String? videoUrl;

    VideoModel({
        this.id,
        this.title,
        this.description,
        this.videoType,
        this.videoUrl,
    });

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        videoType: json["video_type"],
        videoUrl: json["video_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "video_type": videoType,
        "video_url": videoUrl,
    };
}
