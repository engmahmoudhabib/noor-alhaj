import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnoor_emp/employee/conversation/model/chat_model.dart'; 
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class ChatViewController extends GetxController{
  late Dio dio;
  RxBool refreshChat = false.obs ;
  RxList<ChatModel> chats = <ChatModel>[].obs;
  RxBool isSearch = false.obs ;
  RxSet<ChatModel> LastSearch = <ChatModel>{}.obs; 
  late TextEditingController pilgrimName ;

  @override
  onInit(){
    dio = Dio();
    pilgrimName = TextEditingController();
    pilgrimName.addListener(
      () {
        if(pilgrimName.text == '')getChatList2();
        else getChatList2(name: pilgrimName.text);
    },);
    // getChatList();
    getChatList2();
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
   getChatList2({  String? name })async {
    refreshChat.value = true ;
    name == '' ? null : isSearch.value = true ;
    var respone = await dio.get(
      "http://85.31.237.33/test/api/list-chats" , 
      queryParameters: {
        'query':name
      } , 
      options: Options(headers: {
        'Authorization' :'Bearer '+GetStorage().read('access'),
      })
    );
  
    Iterable response2 =respone.data;
    List<ChatModel > list = List<ChatModel>.from(
      response2.map((e) => ChatModel.fromJson(e))
    );
    chats.value = list ;
    chats.refresh();
    refreshChat.value = false ;
    return list; 
  }

  bool ishere(List<ChatModel> list , ChatModel chatModel ){
    String name = chatModel.username ;
    List<String> names = [] ;
    list.map((e) => names.add(e.username));

  
    return names.contains(name)? true : false ;

  }

  // Future<List<ChatModel>> getChatList({  String? name })async {
  //   var response =await http.get(Uri.parse("http://85.31.237.33/test/api/list-chats"));

  //   Iterable response2 = jsonDecode(utf8.decode(response.bodyBytes));
  //   List<ChatModel > list = List<ChatModel>.from(
  //     response2.map((e) => ChatModel.fromJson(e))
  //   );
  //   chats.value = list ;
  //   chats.refresh();
  //   return list; 
  // }

}