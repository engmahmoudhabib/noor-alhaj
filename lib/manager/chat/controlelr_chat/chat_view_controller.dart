import 'package:dio/dio.dart';
import 'package:elnoor_emp/manager/chat/model/chat_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatViewController extends GetxController {
  late Dio dio;
  RxBool refreshChat = false.obs;
  RxList<ChatModel> chats = <ChatModel>[].obs;
  RxList<ChatModel> filteredChats = <ChatModel>[].obs;
  RxBool isSearch = false.obs;
  RxSet<ChatModel> LastSearch = <ChatModel>{}.obs;
  late TextEditingController pilgrimName;

  @override
  void onInit() {
    dio = Dio();
    pilgrimName = TextEditingController();
    pilgrimName.addListener(_searchChats);
    getChatList2();
    super.onInit();
  }

  bool isMorninig(String value) {
    int value2 = int.parse(value);
    return value2 >= 0 && value2 < 12;
  }

  void _searchChats() {
    final query = pilgrimName.text;
    if (query.isEmpty) {
      filteredChats.value = chats;
    } else {
      filteredChats.value = chats.where((chat) {
        return chat.username.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> getChatList2({String? name}) async {
    refreshChat.value = true;
    isSearch.value = name != null && name.isNotEmpty;
    final response = await dio.get(
      "http://alnoor-hajj.com/api/list-manager-chats",
      queryParameters: {'query': name},
    );
    final response2 = response.data as Iterable;
    final list = response2.map((e) => ChatModel.fromJson(e)).toList();
    chats.value = list;
    filteredChats.value = list;
    refreshChat.value = false;
  }

  bool ishere(List<ChatModel> list, ChatModel chatModel) {
    final name = chatModel.username;
    final names = list.map((e) => e.username).toList();
    return names.contains(name);
  }
}
