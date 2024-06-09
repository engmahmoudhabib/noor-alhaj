import 'package:flutter/material.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTabButton extends StatelessWidget {
  final String title;
  final VoidCallback onpressed;
  final bool isActive;
  const ProfileTabButton(
      {super.key,
      required this.title,
      required this.onpressed,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Linkify(
        onOpen: _onOpen,
        text: title,
        style: TextStyle(
          color: isActive ? TColor.primary : TColor.black,
          fontSize: 20,
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
