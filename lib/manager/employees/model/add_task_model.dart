// To parse this JSON data, do
//
//     final addTaskModel = addTaskModelFromJson(jsonString);

import 'dart:convert';

AddTaskModel addTaskModelFromJson(String str) => AddTaskModel.fromJson(json.decode(str));

String addTaskModelToJson(AddTaskModel data) => json.encode(data.toJson());

class AddTaskModel {
    int id;
    String title;
    String content;
    DateTime created;
    bool completed;
    bool accepted;
    int employee;

    AddTaskModel({
        required this.id,
        required this.title,
        required this.content,
        required this.created,
        required this.completed,
        required this.accepted,
        required this.employee,
    });

    factory AddTaskModel.fromJson(Map<String, dynamic> json) => AddTaskModel(
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
