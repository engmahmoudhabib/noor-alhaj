// To parse this JSON data, do
//
//     final guideList = guideListFromJson(jsonString);

import 'dart:convert';

List<GuideList> guideListFromJson(String str) => List<GuideList>.from(json.decode(str).map((x) => GuideList.fromJson(x)));

String guideListToJson(List<GuideList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GuideList {
    int id;
    String username;

    GuideList({
        required this.id,
        required this.username,
    });

    factory GuideList.fromJson(Map<String, dynamic> json) => GuideList(
        id: json["id"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
    };
}
