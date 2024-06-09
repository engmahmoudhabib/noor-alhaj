import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/agent/notification_/view/notification_view.dart';
import 'package:elnoor_emp/splash_acreen/views/splash_screen.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar2 extends StatelessWidget {
  CustomAppBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                icon: Image.asset("assets/img/white_notif_icon.png")),
          ),
          FadeInDownBig(
            delay: Duration(milliseconds: 600),
            child: Linkify(
              onOpen: _onOpen,
              text: "الحساب",
              style: TextStyle(
                  color: TColor.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            ),
          ),
          Row(
            children: [
              FadeInRight(
                delay: Duration(milliseconds: 500),
                child: InkWell(
                    onTap: () {
                      _showLogoutConfirmationDialog(context);
                    },
                    child: Icon(Icons.logout, color: TColor.white)),
              ),
              SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
    );
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
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
