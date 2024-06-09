// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
    String username;
    String image;
    int userId;
    String fullName;
    Tokens tokens;

    LogInModel({
        required this.username,
        required this.image,
        required this.userId,
        required this.fullName,
        required this.tokens,
    });

    factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        username: json["username"],
        image: json["image"],
        userId: json["user_id"],
        fullName: json["full_name"],
        tokens: Tokens.fromJson(json["tokens"]),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "image": image,
        "user_id": userId,
        "full_name": fullName,
        "tokens": tokens.toJson(),
    };
}

class Tokens {
    String refresh;
    String access;

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
