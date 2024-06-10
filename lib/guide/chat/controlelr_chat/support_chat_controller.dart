import 'dart:convert';

import 'package:elnoor_emp/guide/chat/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SupportChatController extends GetxController {
late WebSocketChannel channel ;
late TextEditingController  sendController ;
late RxList<MessageModel> messages = <MessageModel>[].obs;

@override
  void onInit() {
    sendController = TextEditingController();
    
    int id = GetStorage().read("id");
    int chatid = GetStorage().read("chatid"); 
    channel = WebSocketChannel.connect( Uri.parse("ws://alnoor-hajj.com/ws/guide-chat/${chatid}/${id}"));
    channel.stream.listen((event) {
      messages.add(MessageModel.fromJson(jsonDecode(event.toString())));
      // print(messages[0].content);
    });
    super.onInit();
  }

  isMorninig(String value ){
   int value2 = int.parse(value);
    if(value2 >= 0 && value2 < 12)
   { return true ;}
   else {
    return false ;
   }
  }



  void send(){
    // print("sendController.text is " + sendController.text);
      if(sendController.text != "" ){
         Map<String, dynamic> messageJson ={"message": sendController.text }; 
        //  print("2");
        channel.sink.add( jsonEncode(messageJson));
        // print("2"); 
        sendController!.text = '';
      } 
  }
  
  

}