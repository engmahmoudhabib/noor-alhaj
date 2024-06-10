import 'package:elnoor_emp/agent/support_chat/controller/support_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/message_model.dart';

class SupportChat extends StatefulWidget {
  const SupportChat({super.key});

  @override
  State<SupportChat> createState() => _SupportChatState();
}

class _SupportChatState extends State<SupportChat> {
 

  SupportChatController controller = Get.put(SupportChatController());
  @override
  void initState() {
 
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: media.width * 0.4,
            child: ListTile(
              title:Text(  GetStorage().read("guideName") ?? '',
                textAlign: TextAlign.right,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text( "نشط الآن",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  // Image.asset("assets/img/Ellipse.png")
                ],
              ),
              contentPadding: EdgeInsets.zero,
              trailing: CircleAvatar(
                  backgroundImage: NetworkImage(
                 GetStorage().read("guideImage") ?? '',
              )),
            ),
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset("assets/img/white_arrowBack.png")),
        ],
        backgroundColor: TColor.primary,
      ),
      body: Stack(
        children: [
          Container(
            width: media.width,
            height: media.height,
            color: TColor.primary,
          ),
          Positioned(
            top: 20,
            bottom: 0,
            child: Container(
                width: media.width,
                height: media.height,
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                    ),
                    Expanded(
                      child: Obx(
                        () => Padding(
                          padding: EdgeInsets.only(bottom: media.height * 0.1),
                          child: ListView.builder(
                            reverse: true,
                            itemCount: controller.messages.length,
                            itemBuilder: (context, index) {
                              print(controller.messages[index]);
                              List<MessageModel> chat =
                                  controller.messages.reversed.toList();
                              if (chat.length == 0) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (chat[index].sentUser) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 10, top: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: media.width * 0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                           Text(                               
                                               controller.isMorninig(
                                                            chat[index]
                                                                .timestamp
                                                                .hour
                                                                .toString()) ==
                                                        true
                                                    ? "ص"
                                                    : "م"),
                                            Text.rich(TextSpan(children: [
                                              TextSpan(
                                                  text: chat[index]
                                                      .timestamp
                                                      .hour
                                                      .toString()),
                                              const TextSpan(text: ":"),
                                              TextSpan(
                                                  text: chat[index]
                                                      .timestamp
                                                      .minute
                                                      .toString()),
                                            ])),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Wrap(children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: TColor.primary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    25),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    25),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    25))),
                                                // width: media.width * 0.7,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child:Text(                                         
                                                     chat[index].content,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      textDirection:
                                                          TextDirection.rtl),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          width: media.width * 0.1,
                                          child: const CircleAvatar(
                                              child: Icon(Icons.person)))
                                    ],
                                  ),
                                );
                              } else if (!chat[index].sentUser) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 10,
                                    top: 24,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: media.width * 0.1,
                                          child: const CircleAvatar(
                                              child: Icon(Icons.person))),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: media.width * 0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Wrap(children: [
                                              Container(
                                                // width: media.width * 0.7,
                                                decoration: BoxDecoration(
                                                    color: TColor.primary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    25),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    25),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    25))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child:Text(                                        
                                                      chat[index].content,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      textDirection:
                                                          TextDirection.rtl),
                                                ),
                                              ),
                                            ]),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                           Text(                                   
                                                controller.isMorninig(
                                                            chat[index]
                                                                .timestamp
                                                                .hour
                                                                .toString()) ==
                                                        true
                                                    ? "ص"
                                                    : "م"),
                                            Text.rich(TextSpan(children: [
                                              TextSpan(
                                                  text: chat[index]
                                                      .timestamp
                                                      .hour
                                                      .toString()),
                                              const TextSpan(text: ":"),
                                              TextSpan(
                                                  text: chat[index]
                                                      .timestamp
                                                      .minute
                                                      .toString()),
                                            ])),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            bottom: 3,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: media.height * 0.09,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        height: media.height * 0.2,
                        width: media.width * 0.75,
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: controller.sendController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'اكتب هنا . .',
                          ),
                        ),
                      ),
                      // IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.faceSmile , )),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                      onTap: () {
                        controller.send();
                      },
                      child: Image.asset(
                        "assets/img/send.png",
                        width: 56,
                        height: 56,
                      )),
                ],
              ),
            ),
          )
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
