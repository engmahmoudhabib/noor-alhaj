import 'package:flutter/material.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class IconPrimaryButton extends StatelessWidget {
  void Function()? onTap;
  final String text;
  final IconData icon;
  IconPrimaryButton(
      {super.key, required this.onTap, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: TColor.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        padding:
            EdgeInsets.symmetric(vertical: 15, horizontal: media.width / 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Linkify(
              onOpen: _onOpen,
              text: text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
            Icon(
              icon,
              color: TColor.white,
              size: 20,
            ),
          ],
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
