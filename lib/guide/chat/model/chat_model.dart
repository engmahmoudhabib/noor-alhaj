// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
    final int id;
    final String image;
    final String username;
    final String lastMsg;
    final DateTime created;
    final String chatType;
    final int user;

    ChatModel({
        required this.id,
        required this.image,
        required this.username,
        required this.lastMsg,
        required this.created,
        required this.chatType,
        required this.user,
    });

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        image: json["image"],
        username: json["username"],
        lastMsg: json["last_msg"],
        created: DateTime.parse(json["created"]),
        chatType: json["chat_type"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "username": username,
        "last_msg": lastMsg,
        "created": created.toIso8601String(),
        "chat_type": chatType,
        "user": user,
    };
}
