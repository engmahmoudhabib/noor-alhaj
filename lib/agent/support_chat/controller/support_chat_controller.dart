import 'dart:convert';

import 'package:elnoor_emp/agent/support_chat/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SupportChatController extends GetxController {
  late WebSocketChannel? channel; // Make channel nullable to handle errors
  late TextEditingController sendController;
  late RxList<MessageModel> messages = <MessageModel>[].obs;

  @override
  void onInit() {
    sendController = TextEditingController();

    int idchat = GetStorage().read("guideChatId");
    int id = GetStorage().read("id");

    try {
      channel = WebSocketChannel.connect(
          Uri.parse("ws://85.31.237.33/al-noor/ws/guide-chat/$idchat/$id"));

      channel!.stream.listen((event) {
        messages.add(MessageModel.fromJson(jsonDecode(event.toString())));
        print(messages[0].content); // For debugging
      });
    } catch (error) {
      print("WebSocket connection error: $error");
    }

    super.onInit();
  }

  bool isMorninig(String value) {
    int value2 = int.parse(value);
    return value2 >= 0 && value2 < 12;
  }

  void send() {
    print("sendController.text is " + sendController.text);
    if (sendController.text != "") {
      Map<String, dynamic> messageJson = {"message": sendController.text};
      print("Sending message: ${jsonEncode(messageJson)}"); // For debugging
      try {
        channel?.sink.add(jsonEncode(messageJson));
        sendController!.text = '';
      } catch (error) {
        print("Error sending message: $error"); // For debugging
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    channel?.sink.close(); // Close the connection when the controller closes
  }
}
