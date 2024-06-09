import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/agent/user_profile/controller/profile_controller.dart';
import 'package:elnoor_emp/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../notification_/view/notification_view.dart';
import '../user_profile/view/user_profile_view.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final ProfileController controller = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeInLeft(
                delay: Duration(milliseconds: 500),
                child: IconButton(
                    onPressed: () {
                      Get.to(AddNotification());
                    },
                    icon: Image.asset(
                      "assets/img/white_notif_icon.png",
                      color: TColor.primary,
                    )),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ZoomIn(
                        curve: Curves.decelerate,
                        delay: Duration(milliseconds: 600),
                        child: Linkify(
                          onOpen: _onOpen,
                          text: "حياك الله اخي الكريم",
                        ),
                      ),
                      ZoomIn(
                        delay: Duration(milliseconds: 600),
                        curve: Curves.decelerate,
                        child: Linkify(
                          onOpen: _onOpen,
                          text: GetStorage().read('username'),
                          style: const TextStyle(color: TColor.primary),
                        ),
                      ), //in this text it will be the TextController from the textfield
                    ],
                  ),
                  FadeInRight(
                    delay: Duration(milliseconds: 500),
                    child: InkWell(
                        onTap: () {
                          Get.to(UserProfileView());
                        },
                        child: CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: controller.imagePath.value == null
                              ? AssetImage("assets/img/bg.png")
                                  as ImageProvider<Object>?
                              : (Uri.tryParse(controller.imagePath.value!)
                                          ?.isAbsolute ==
                                      true
                                  ? NetworkImage(controller.imagePath.value!)
                                  : FileImage(File(controller.imagePath
                                      .value!))) as ImageProvider<Object>?,
                        )),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     Get.to(const UserProfileView());
                  //   },
                  //   icon: controller.imagePath.value == null
                  //       ? Image.asset("assets/img/avatar.png") as Widget
                  //       : File(controller.imagePath.value!)
                  //           as Widget,
                  // ),
                ],
              ),
            ],
          ),
        ));
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
