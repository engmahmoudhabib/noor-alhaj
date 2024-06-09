// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? username;
  int? guideChatId;
  int? managerChatId;
  String? image;
  int? userId;
  String? userType;
  String? fullName;
  int? pilgrimId;
  String? guideImage;
  String? guideName;
  Tokens? tokens;

  LoginModel(
      {this.username,
      this.guideChatId,
      this.managerChatId,
      this.image,
      this.userId,
      this.userType,
      this.fullName,
      this.pilgrimId,
      this.guideImage,
      this.guideName,
      this.tokens});

  LoginModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    guideChatId = json['guide_chat_id'];
    managerChatId = json['manager_chat_id'];
    image = json['image'];
    userId = json['user_id'];
    userType = json['user_type'];
    fullName = json['full_name'];
    pilgrimId = json['pilgrim_id'];
    guideImage = json['guide_image'];
    guideName = json['guide_name'];
    tokens =
        json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['guide_chat_id'] = guideChatId;
    data['manager_chat_id'] = managerChatId;
    data['image'] = image;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['full_name'] = fullName;
    data['pilgrim_id'] = pilgrimId;
    data['guide_image'] = guideImage;
    data['guide_name'] = guideName;
    if (tokens != null) {
      data['tokens'] = tokens!.toJson();
    }
    return data;
  }
}

class Tokens {
  String? refresh;
  String? access;

  Tokens({this.refresh, this.access});

  Tokens.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    return data;
  }
}
