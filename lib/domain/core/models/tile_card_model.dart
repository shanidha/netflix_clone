// To parse this JSON data, do
//
//     final tileCardModel = tileCardModelFromJson(jsonString);

import 'dart:convert';

TileCardModel tileCardModelFromJson(String str) =>
    TileCardModel.fromJson(json.decode(str));

String tileCardModelToJson(TileCardModel data) => json.encode(data.toJson());

class TileCardModel {
  List<Result> results;

  TileCardModel({
    required this.results,
  });

  factory TileCardModel.fromJson(Map<String, dynamic> json) => TileCardModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  String? title;
  String? overview;
  String? posterPath;
  String? mediaType;  DateTime? releaseDate;

  Result({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    this.releaseDate
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"] ?? "",
           releaseDate: json["release_date"] != null && json["release_date"] != ""
            ? DateTime.tryParse(json["release_date"])
            : null, 
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
         "release_date": releaseDate != null
            ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
            : null,
        
      };
}
