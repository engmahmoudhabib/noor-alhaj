import 'package:flutter/material.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondaryButton extends StatelessWidget {
  String text;
  void Function()? onTap;
  SecondaryButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          decoration: BoxDecoration(
              color: TColor.primary, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Linkify(
                  onOpen: _onOpen,
                  text: text,
                  style: TextStyle(
                    color: TColor.white,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.check,
                  color: TColor.white,
                ),
              ],
            ),
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
