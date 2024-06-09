// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../comon_widgets/custom_text_field.dart';

import '../../comon_widgets/primary_button.dart';

import 'package:elnoor_emp/theme.dart';
import '../controller/notification_controller.dart';

class NewNotification extends StatefulWidget {
  const NewNotification({super.key});

  @override
  State<NewNotification> createState() => _NewNotificationState();
}

class _NewNotificationState extends State<NewNotification> {
  final controller = Get.put(NotificationController());
  clearText() {
    controller.notiName.clear();
    controller.notiContent.clear();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          FadeInRight(
            delay: Duration(milliseconds: 500),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Image.asset(
                  "assets/img/whiteArr.png",
                  color: TColor.black,
                )),
          )
        ],
        title: FadeInDown(
            delay: Duration(milliseconds: 800),
            child: const Linkify(onOpen: _onOpen, text: 'إضافة اشعار')),
      ),
      body: SingleChildScrollView(
        child: GetBuilder(
            init: NotificationController(),
            builder: (controller) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  FadeInRight(
                    delay: Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * 0.05),
                          child: const Linkify(
                              onOpen: _onOpen, text: " عنوان الاشعار"),
                        ),
                        const SizedBox(height: 11),
                        CustomTextField(
                          txtController: controller.notiName,
                          hintText: "عنوان الاشعار",
                          keyboardType: TextInputType.name,
                        ),
                      ],
                    ),
                  ),
                  FadeInLeft(
                    delay: Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * 0.05),
                          child: const Linkify(
                              onOpen: _onOpen, text: "  محتوي الاشعار"),
                        ),
                        // const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            controller: controller.notiContent,
                            textAlign: TextAlign.end,
                            maxLines: 6,
                            decoration: InputDecoration(
                              hintText: "محتوى الاشعار",
                              hintTextDirection: TextDirection.ltr,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: TColor.primary)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ZoomIn(
                      curve: Curves.linear,
                      delay: Duration(milliseconds: 650),
                      child: PrimaryButton(
                          onTap: () {
                            controller.sendNotification();
                            clearText();
                            if (controller.isDone == true) {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      content: Container(
                                        height: 100,
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.done_all_outlined,
                                              size: 60,
                                              color: TColor.primary,
                                            ),
                                            Linkify(
                                                onOpen: _onOpen,
                                                text: "تم ارسال الاشعار"),
                                          ],
                                        ),
                                      ),
                                    );
                                  }));
                            }
                          },
                          text: "اضف"))
                ],
              );
            }),
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
