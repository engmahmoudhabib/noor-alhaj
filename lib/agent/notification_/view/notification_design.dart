import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDesign extends StatelessWidget {
  String day;
  String content;
  String hour;
  String title;
  NotificationDesign({
    super.key,
    required this.content,
    required this.day,
    required this.hour,
    required this.title,
  });

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Linkify(
                onOpen: _onOpen,
                text: title,
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: Linkify(
                  onOpen: _onOpen,
                  text: content,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  style: TextStyle(
                      color: TColor.black.withOpacity(0.4),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: day,
                    style: TextStyle(
                        color: TColor.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "  .  ",
                    style: TextStyle(
                        color: TColor.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: hour,
                    style: TextStyle(
                        color: TColor.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
              const SizedBox(height: 5),
            ],
          ),
          const SizedBox(width: 10),
          Image.asset(
            "assets/img/addNotification.png",
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
