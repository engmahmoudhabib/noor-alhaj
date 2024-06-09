// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
    final String username;
    final int guideChatId;
    final int managerChatId;
    final String image;
    final int userId;
    final String fullName;
    final int pilgrimId;
    final String guideImage;
    final String guideName;
    final Tokens tokens;

    LogInModel({
        required this.username,
        required this.guideChatId,
        required this.managerChatId,
        required this.image,
        required this.userId,
        required this.fullName,
        required this.pilgrimId,
        required this.guideImage,
        required this.guideName,
        required this.tokens,
    });

    factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        username: json["username"],
        guideChatId: json["guide_chat_id"],
        managerChatId: json["manager_chat_id"],
        image: json["image"],
        userId: json["user_id"],
        fullName: json["full_name"],
        pilgrimId: json["pilgrim_id"],
        guideImage: json["guide_image"],
        guideName: json["guide_name"],
        tokens: Tokens.fromJson(json["tokens"]),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "guide_chat_id": guideChatId,
        "manager_chat_id": managerChatId,
        "image": image,
        "user_id": userId,
        "full_name": fullName,
        "pilgrim_id": pilgrimId,
        "guide_image": guideImage,
        "guide_name": guideName,
        "tokens": tokens.toJson(),
    };
}

class Tokens {
    final String refresh;
    final String access;

    Tokens({
        required this.refresh,
        required this.access,
    });

    factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        refresh: json["refresh"],
        access: json["access"],
    );

    Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
    };
}
