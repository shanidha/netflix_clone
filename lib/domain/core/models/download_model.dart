// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DownloadsData welcomeFromJson(String str) => DownloadsData.fromJson(json.decode(str));

String welcomeToJson(DownloadsData data) => json.encode(data.toJson());

class DownloadsData {
    Downloads downloads;

    DownloadsData({
        required this.downloads,
    });

    factory DownloadsData.fromJson(Map<String, dynamic> json) => DownloadsData(
        downloads: Downloads.fromJson(json["downloads"]),
    );

    Map<String, dynamic> toJson() => {
        "downloads": downloads.toJson(),
    };
}

class Downloads {
    int id;
    String title;
    String subtitle;
    String posterPath;
    String originalLanguage;
    List<String> posters;

    Downloads({
        required this.id,
        required this.title,
        required this.subtitle,
        required this.posterPath,
        required this.originalLanguage,
        required this.posters,
    });

    factory Downloads.fromJson(Map<String, dynamic> json) => Downloads(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        posterPath: json["poster_path"],
        originalLanguage: json["original_language"],
        posters: List<String>.from(json["posters"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "poster_path": posterPath,
        "original_language": originalLanguage,
        "posters": List<dynamic>.from(posters.map((x) => x)),
    };
}
