import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/guide/add_notification/add_notification_controller/addNotificaionController.dart';
import 'package:elnoor_emp/guide/add_notification/model/notificaitonmodel.dart';
import 'package:elnoor_emp/guide/add_notification/views/add_new_notification.dart';
import 'package:elnoor_emp/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'notification_design.dart';

class AddNotification extends StatefulWidget {
  const AddNotification({super.key});

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  AddNotificationController controller = Get.put(AddNotificationController());
  @override
  void initState() {
    controller.getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeInDown(
            delay: Duration(milliseconds: 500),
            child: const Linkify(onOpen: _onOpen, text: " الاشعارات")),
        centerTitle: true,
        actions: [
          FadeInRight(
            delay: Duration(milliseconds: 500),
            child: IconButton(
              onPressed: () {
                Get.to(() => const NewNotification());
              },
              icon: const Icon(Icons.add),
              color: TColor.black,
              iconSize: 30,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<NotificationModel>>(
            future: controller.getNotification(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("waiting");
                return Center(
                  child: CircularProgressIndicator(
                    color: TColor.primary,
                  ),
                );
              } else if (!snapshot.hasData) {
                print("!snapshot.hasData");
                return Container();
              } else if (snapshot.hasData) {
                print("snapshot.hasData");
                List<NotificationModel>? notifcaionts = snapshot.data;
                return ListView.builder(
                    itemCount: notifcaionts!.length,
                    itemBuilder: (context, index) {
                      String period = controller.isMorninig(
                              notifcaionts[index].created.hour.toString())
                          ? "ص"
                          : "م";
                      String hour =
                          " ${notifcaionts[index].created.hour}:${notifcaionts[index].created.minute} ${period}";
                   String day = notifcaionts[index].created.day.toString() +
                          '/' +
                          notifcaionts[index].created.month.toString() +
                          '/' +
                          notifcaionts[index].created.year.toString();
                      return FadeInRight(
                          delay: Duration(milliseconds: 500),
                          curve: Curves.easeInSine,
                          child: NotificationDesign(
                            content: notifcaionts[index].content,
                            hour: hour,
                            day: day,
                            title: notifcaionts[index].title,
                          ));
                    });
              } else {
                print("Container");
                return Center(
                  child: CircularProgressIndicator(
                    color: TColor.primary,
                  ),
                );
              }
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
