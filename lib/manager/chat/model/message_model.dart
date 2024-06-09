// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
    final int id;
    final String content;
    final DateTime timestamp;
    final bool sentUser;
    final int sender;
    final int chat;

    MessageModel({
        required this.id,
        required this.content,
        required this.timestamp,
        required this.sentUser,
        required this.sender,
        required this.chat,
    });

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        content: json["content"],
        timestamp: DateTime.parse(json["timestamp"]),
        sentUser: json["sent_user"],
        sender: json["sender"],
        chat: json["chat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "timestamp": timestamp.toIso8601String(),
        "sent_user": sentUser,
        "sender": sender,
        "chat": chat,
    };
}
