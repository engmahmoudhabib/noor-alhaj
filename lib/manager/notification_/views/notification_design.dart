import 'package:flutter/material.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDesign extends StatelessWidget {
  const NotificationDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10)),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Linkify(
                onOpen: _onOpen,
                text: "the name of the noti ",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              Linkify(
                onOpen: _onOpen,
                text: "the content of the noti ",
                style: TextStyle(
                  color: TColor.black.withOpacity(0.4),
                  fontSize: 11,
                ),
              ),
              const Linkify(
                onOpen: _onOpen,
                text: "the time of the noti",
                style: TextStyle(color: TColor.primary, fontSize: 9),
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
