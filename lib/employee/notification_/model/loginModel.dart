// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    final String username;
    final String image;
    final int userId;
    final Tokens tokens;

    LoginModel({
        required this.username,
        required this.image,
        required this.userId,
        required this.tokens,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        username: json["username"],
        image: json["image"],
        userId: json["user_id"],
        tokens: Tokens.fromJson(json["tokens"]),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "image": image,
        "user_id": userId,
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
