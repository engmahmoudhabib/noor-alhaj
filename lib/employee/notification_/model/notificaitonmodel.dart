// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    final int id;
    final String title;
    final String content;
    final String info;
    final DateTime created;
    final int user;

    NotificationModel({
        required this.id,
        required this.title,
        required this.content,
        required this.info,
        required this.created,
        required this.user,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
