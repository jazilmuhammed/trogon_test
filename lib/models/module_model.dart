// To parse this JSON data, do
//
//     final moduleModel = moduleModelFromJson(jsonString);

import 'dart:convert';

List<ModuleModel> moduleModelFromJson(String str) => List<ModuleModel>.from(json.decode(str).map((x) => ModuleModel.fromJson(x)));

String moduleModelToJson(List<ModuleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModuleModel {
    int? id;
    String? title;
    String? description;

    ModuleModel({
        this.id,
        this.title,
        this.description,
    });

    factory ModuleModel.fromJson(Map<String, dynamic> json) => ModuleModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
    };
}
