// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/notification_controller.dart';
import 'add_new_notification.dart';
import 'notification_design.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FadeInDown(
            delay: Duration(milliseconds: 500),
            child: const Linkify(onOpen: _onOpen, text: " الاشعارات")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: controller.showNotification(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: TColor.primary,
                ));
              } else if (snapshot.hasError) {
                return Center(
                    child: Linkify(
                        onOpen: _onOpen, text: 'Error: ${snapshot.error}'));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data![index];
                      return FadeInRight(
                          delay: Duration(milliseconds: 500),
                          curve: Curves.easeInSine,
                          child: InkWell(
                            onTap: () {
                              // controller.showNotification();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Linkify(
                                          onOpen: _onOpen,
                                          text: data.title,
                                          style: TextStyle(
                                              color: TColor.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Linkify(
                                          onOpen: _onOpen,
                                          text: data.content,
                                          style: TextStyle(
                                            color:
                                                TColor.black.withOpacity(0.4),
                                            fontSize: 11,
                                          ),
                                        ),
                                        Linkify(
                                          onOpen: _onOpen,
                                          text: data.created
                                              .toString()
                                              .substring(0, 11),
                                          style: TextStyle(
                                              color: TColor.primary,
                                              fontSize: 9),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset(
                                      "assets/img/arrowBack_icon.jpg",
                                    )
                                  ]),
                            ),
                          ));
                    });
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
