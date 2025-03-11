// To parse this JSON data, do
//
//     final netflixModel = netflixModelFromJson(jsonString);

import 'dart:convert';

NetflixModel netflixModelFromJson(String str) => NetflixModel.fromJson(json.decode(str));

String netflixModelToJson(NetflixModel data) => json.encode(data.toJson());

class NetflixModel {
    List<String> posters;
    List<String> shows;
    List<String> list;

    NetflixModel({
        required this.posters,
        required this.shows,
        required this.list,
    });

    factory NetflixModel.fromJson(Map<String, dynamic> json) => NetflixModel(
        posters: List<String>.from(json["posters"].map((x) => x)),
        shows: List<String>.from(json["shows"].map((x) => x)),
        list: List<String>.from(json["list"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "posters": List<dynamic>.from(posters.map((x) => x)),
        "shows": List<dynamic>.from(shows.map((x) => x)),
        "list": List<dynamic>.from(list.map((x) => x)),
    };
}
