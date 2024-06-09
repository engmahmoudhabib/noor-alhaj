// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/manager/chat/controlelr_chat/chat_view_controller.dart';
import 'package:elnoor_emp/manager/chat/model/chat_model.dart';
import 'package:elnoor_emp/manager/chat/views/chat_user.dart';
import 'package:elnoor_emp/manager/comon_widgets/search_bar.dart';
import 'package:elnoor_emp/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ChatViewController controller = Get.put(ChatViewController());

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FadeInDown(
            delay: const Duration(milliseconds: 650),
            child: const Linkify(onOpen: _onOpen, text: " بدء الدردشة")),
        centerTitle: true,
        actions: [],
      ),
      body: Obx(
        () =>controller.refreshChat.value
              ? Center(
                  child: CircularProgressIndicator(
                  color: TColor.primary,
                ))
              : Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const SizedBox(
            height: 10,
          ),
          CustomSearchBar(
            whenComplete: () {
              // if(controller.pilgrimName){controller.getChatList2(name: controller.pilgrimName.text);}else{controller.getChatList2();}
            },
            controller: controller.pilgrimName,
          ),
          const SizedBox(
            height: 10,
          ),
        
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Linkify(
              onOpen: _onOpen,
              text: 'جميع المحادثات',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xFF4E5051),
              ),
            ),
          ),
          Obx(() => controller.refreshChat.value
              ? Center(
                  child: CircularProgressIndicator(
                  color: TColor.primary,
                ))
              : Expanded(
                  child: ListView.builder(
                    itemCount: controller.chats.length,
                    itemBuilder: (context, index) {
                      String period = controller.isMorninig(
                              controller.chats[index].created.hour.toString())
                          ? "ص"
                          : "م";
                      String hour =
                          " ${controller.chats[index].created.hour}:${controller.chats[index].created.minute} ${period}  ";
                      return InkWell(
                        onTap: () {
                          // controller.LastSearch.add(controller.chats[index]);
                          controller.LastSearch.any((element) =>
                                  element.id == controller.chats[index].id)
                              ? null
                              : controller.LastSearch.add(
                                  controller.chats[index]);
                          for (var i in controller.LastSearch) {
                            print(i.username);
                          }
                          print(controller.LastSearch.length);
                          // controller.LastSearch.clear();
                          GetStorage()
                              .write("chatid", controller.chats[index].id);
                          Get.to(UserChat(
                              name: controller.chats[index].username,
                              image: controller.chats[index].image));
                        },
                        child: ContainerChat(
                          image: controller.chats[index].image,
                          lastmessage: controller.chats[index].lastMsg,
                          time: hour,
                          username: controller.chats[index].username,
                        ),
                      );
                    },
                  ),
                )),
        ]),
      ),
    );
  }
}

class ChatIcon extends StatelessWidget {
  String image;
  String name;
  ChatIcon({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Color.fromARGB(255, 21, 182, 26)),
                image: DecorationImage(image: NetworkImage(image))),
          ),
          SizedBox(
            width: 10,
          ),
          Linkify(onOpen: _onOpen, text: name)
        ],
      ),
    );
  }
}

class ContainerChat extends StatelessWidget {
  String username;
  String lastmessage;
  String time;
  String image;
  ContainerChat(
      {super.key,
      required this.image,
      required this.lastmessage,
      required this.time,
      required this.username});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: TColor.black.withOpacity(0.3)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Linkify(
                  onOpen: _onOpen,
                  text: username,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: TColor.black.withOpacity(0.7)),
                ),
                Container(
                  width: media.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //     Text.rich(
                      //       TextSpan(
                      //         children: [
                      //           TextSpan(text: "م", style: TextStyle(
                      //             fontSize: 12 ,
                      // fontWeight: FontWeight.w400 ,
                      // color: TColor.black.withOpacity(0.7)
                      //           )),
                      //           TextSpan(text: time , style: TextStyle(
                      //             fontSize: 12 ,
                      // fontWeight: FontWeight.w400 ,
                      // color: TColor.black.withOpacity(0.7)
                      //           ))
                      //         ]
                      //       ),
                      //     ),
                      Linkify(
                        onOpen: _onOpen,
                        text: " ${time} ",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: TColor.black.withOpacity(0.7)),
                      ),
                      Linkify(
                        onOpen: _onOpen,
                        text: lastmessage,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: TColor.black.withOpacity(0.7)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Color.fromARGB(255, 21, 182, 26)),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.fill)),
          ),
        ],
      ),
    );
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
