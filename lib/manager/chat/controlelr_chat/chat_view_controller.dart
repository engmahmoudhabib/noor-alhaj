import 'package:dio/dio.dart';
import 'package:elnoor_emp/manager/chat/model/chat_model.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatViewController extends GetxController {
  late Dio dio;
  RxBool refreshChat = false.obs;
  RxList<ChatModel> chats = <ChatModel>[].obs;
  RxBool isSearch = false.obs;
  RxSet<ChatModel> LastSearch = <ChatModel>{}.obs;
  late TextEditingController pilgrimName;

  @override
  onInit() {
    dio = Dio();
    pilgrimName = TextEditingController();
    pilgrimName.addListener(
      () {
        if (pilgrimName.text == '')
          getChatList2();
        else
          getChatList2(name: pilgrimName.text);
      },
    );
    // getChatList();
    getChatList2();
    super.onInit();
  }

  isMorninig(String value) {
    int value2 = int.parse(value);
    if (value2 >= 0 && value2 < 12) {
      return true;
    } else {
      return false;
    }
  }

  getChatList2({String? name}) async {
    refreshChat.value = true;
    name == '' ? null : isSearch.value = true;
    var respone = await dio.get("http://alnoor-hajj.com/api/list-manager-chats",
        queryParameters: {'query': name});
    print(respone.data);
    Iterable response2 = respone.data;
    List<ChatModel> list =
        List<ChatModel>.from(response2.map((e) => ChatModel.fromJson(e)));
    chats.value = list;
    chats.refresh();
    refreshChat.value = false;
    return list;
  }

  bool ishere(List<ChatModel> list, ChatModel chatModel) {
    String name = chatModel.username;
    List<String> names = [];
    list.map((e) => names.add(e.username));
    for (var i in names) {
      print(i);
    }
    // names.map((e) => print(e));
    return names.contains(name) ? true : false;
  }

  // Future<List<ChatModel>> getChatList({  String? name })async {
  //   var response =await http.get(Uri.parse("http://alnoor-hajj.com/api/list-chats"));
  //   print(jsonDecode(utf8.decode(response.bodyBytes)));
  //   Iterable response2 = jsonDecode(utf8.decode(response.bodyBytes));
  //   List<ChatModel > list = List<ChatModel>.from(
  //     response2.map((e) => ChatModel.fromJson(e))
  //   );
  //   chats.value = list ;
  //   chats.refresh();
  //   return list;
  // }
}
