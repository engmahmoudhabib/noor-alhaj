// To parse this JSON data, do
//
//     final tasksModel = tasksModelFromJson(jsonString);

import 'dart:convert';

List<TasksModel> tasksModelFromJson(String str) =>
    List<TasksModel>.from(json.decode(str).map((x) => TasksModel.fromJson(x)));

String tasksModelToJson(List<TasksModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TasksModel {
  int id;
  String title;
  String content;
  DateTime created;
  bool completed;
  bool accepted;
  int employee;

  TasksModel({
    required this.id,
    required this.title,
    required this.content,
    required this.created,
    required this.completed,
    required this.accepted,
    required this.employee,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
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
