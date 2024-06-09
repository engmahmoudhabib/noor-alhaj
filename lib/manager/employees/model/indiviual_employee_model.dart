// To parse this JSON data, do
//
//     final indiviualEmployeeModel = indiviualEmployeeModelFromJson(jsonString);

import 'dart:convert';

IndiviualEmployeeModel indiviualEmployeeModelFromJson(String str) => IndiviualEmployeeModel.fromJson(json.decode(str));

String indiviualEmployeeModelToJson(IndiviualEmployeeModel data) => json.encode(data.toJson());

class IndiviualEmployeeModel {
    int id;
    int user;
    String? phonenumber;
    String? username;
    String? email;
    String? image;

    IndiviualEmployeeModel({
        required this.id,
        required this.user,
        required this.phonenumber,
        required this.username,
        required this.email,
        required this.image,
    });

    factory IndiviualEmployeeModel.fromJson(Map<String, dynamic> json) => IndiviualEmployeeModel(
        id: json["id"],
        user: json["user"],
        phonenumber: json["phonenumber"],
        username: json["username"],
        email: json["email"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "phonenumber": phonenumber,
        "username": username,
        "email": email,
        "image": image,
    };
}
