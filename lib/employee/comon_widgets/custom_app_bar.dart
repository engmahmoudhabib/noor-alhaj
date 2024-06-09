import 'dart:io';
import 'package:elnoor_emp/splash_acreen/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../notification_/views/notification.dart';
import 'package:elnoor_emp/theme.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInLeftBig(
            delay: Duration(milliseconds: 800),
            child: IconButton(
                onPressed: () {
                    _showLogoutConfirmationDialog(context);
                },
                icon: Icon(Icons.logout, color: Colors.black,)),
          ),
            FadeInLeftBig(
            delay: Duration(milliseconds: 800),
            child: IconButton(
                onPressed: () {
                  Get.to(NotificationView());
                },
                icon: Image.asset("assets/img/notification_icon.png")),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Linkify(
                    onOpen: _onOpen,
                    text: widget.title,
                  ),
                  Linkify(
                    onOpen: _onOpen,
                    text: "${storage.read("username")}",
                    style: const TextStyle(color: TColor.primary),
                  ), //in this text it will be the TextController from the textfield
                ],
              ),
              FadeInRightBig(
                delay: Duration(milliseconds: 800),
                child: IconButton(
                    onPressed: () {
                      // Get.to(const UserProfileView());
                    },
                    icon: Image.asset("assets/img/avatar.png") as Widget),
              ),
            ],
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
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Linkify(
            onOpen: _onOpen,
            text: 'تسجيل الخروج',
            textAlign: TextAlign.center,
          ),
          content: Linkify(
            onOpen: _onOpen,
            text: 'هل انت متأكد من تسجيل الخروج ؟',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Linkify(onOpen: _onOpen, text: 'إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Clear all GetX storage data
                         GetStorage().remove("id",);
      GetStorage().remove("refresh", );
      GetStorage().remove("access", );
      GetStorage().remove("username",);
      GetStorage().remove("pilgramId", );
      GetStorage().remove("ManagerChatId", );
      GetStorage().remove("guideChatId", );
      GetStorage().remove("userType", );
      GetStorage().remove('tawaf', );
      GetStorage().remove('saee', );
                // Navigate to SplashScreen
                Get.offAll(SplashScreen());
              },
              child: Linkify(onOpen: _onOpen, text: 'موافق'),
            ),
          ],
        );
      },
    );
  }
