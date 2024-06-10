import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/guide/add_notification/add_notification_controller/addNotificaionController.dart';
import 'package:elnoor_emp/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../comon_widgets/custom_text_field.dart';
import '../../comon_widgets/number_text_field.dart';
import '../../comon_widgets/password_custome_text_field.dart';
import '../../comon_widgets/primary_button.dart';
class NewNotification extends StatefulWidget {
  const NewNotification({super.key});

  @override
  State<NewNotification> createState() => _NewNotificationState();
}

class _NewNotificationState extends State<NewNotification> {
  AddNotificationController controller = Get.put(AddNotificationController());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: FadeInDown(
          delay: Duration(milliseconds: 800),
          child: const Linkify(onOpen: _onOpen, text: 'إضافة اشعار'),
        ),
        actions: [
          FadeInRight(
            delay: Duration(milliseconds: 800),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                "assets/img/white_arrowBack.png",
                color: TColor.black,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              FadeInRight(
                delay: Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: media.width * 0.05),
                      child: const Linkify(onOpen: _onOpen, text: " عنوان الاشعار"),
                    ),
                    const SizedBox(height: 11),
                    CustomTextField(
                      controller: controller.title,
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
                      padding: EdgeInsets.symmetric(horizontal: media.width * 0.05),
                      child: const Linkify(onOpen: _onOpen, text: "  محتوي الاشعار"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: controller.content,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: "محتوى الاشعار",
                          hintTextDirection: TextDirection.rtl,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ZoomIn(
                      curve: Curves.linear,
                      delay: Duration(milliseconds: 650),
                      child: PrimaryButton(
                        onTap: () {
                          controller.sendNotification();
                        },
                        text: "اضف",
                      ),
                    ),
            ],
          ),
        ),
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
