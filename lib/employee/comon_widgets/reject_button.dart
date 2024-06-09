import 'package:flutter/material.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class RejectButton extends StatelessWidget {
  const RejectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          decoration: BoxDecoration(
              color: TColor.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20)),
          child: const Row(
            children: [
              Linkify(
                onOpen: _onOpen,
                text: "رفض",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.close,
                color: Colors.red,
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
