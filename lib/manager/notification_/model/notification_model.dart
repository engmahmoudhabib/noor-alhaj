// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  int id;
  String title;
  String content;
  String info;
  DateTime created;
  int user;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.info,
    required this.created,
    required this.user,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        info: json["info"],
        created: DateTime.parse(json["created"]),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "info": info,
        "created": created.toIso8601String(),
        "user": user,
      };
}
