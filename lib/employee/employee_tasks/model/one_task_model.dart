// To parse this JSON data, do
//
//     final oneTaskModel = oneTaskModelFromJson(jsonString);

import 'dart:convert';

OneTaskModel oneTaskModelFromJson(String str) => OneTaskModel.fromJson(json.decode(str));

String oneTaskModelToJson(OneTaskModel data) => json.encode(data.toJson());

class OneTaskModel {
    int id;
    String title;
    String content;
    DateTime created;
    bool completed;
    bool accepted;
    int employee;

    OneTaskModel({
        required this.id,
        required this.title,
        required this.content,
        required this.created,
        required this.completed,
        required this.accepted,
        required this.employee,
    });

    factory OneTaskModel.fromJson(Map<String, dynamic> json) => OneTaskModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        created: DateTime.parse(json["created"]),
        completed: json["completed"],
        accepted: json["accepted"],
        employee: json["employee"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "created": created.toIso8601String(),
        "completed": completed,
        "accepted": accepted,
        "employee": employee,
    };
}
