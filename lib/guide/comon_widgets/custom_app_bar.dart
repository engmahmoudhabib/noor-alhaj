import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final String name;
  const CustomAppBar({super.key, required this.title, required this.name});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
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
                  // Get.to(NotificationView());
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
                    text: widget.name,
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
