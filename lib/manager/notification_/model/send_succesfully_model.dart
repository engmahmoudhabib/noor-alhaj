// To parse this JSON data, do
//
//     final notificationDone = notificationDoneFromJson(jsonString);

import 'dart:convert';

NotificationDone notificationDoneFromJson(String str) => NotificationDone.fromJson(json.decode(str));

String notificationDoneToJson(NotificationDone data) => json.encode(data.toJson());

class NotificationDone {
    String message;

    NotificationDone({
        required this.message,
    });

    factory NotificationDone.fromJson(Map<String, dynamic> json) => NotificationDone(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
