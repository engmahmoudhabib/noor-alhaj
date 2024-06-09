import 'package:flutter/material.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class StepCircle extends StatelessWidget {
  String index;
  String title;
  Function()? onTap;
  StepCircle(
      {super.key,
      required this.index,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: TColor.primary,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: TColor.primary, blurRadius: 3)]),
            child: Center(
                child: Linkify(
              onOpen: _onOpen,
              text: index,
              style: TextStyle(color: TColor.white),
            )),
          ),
        ),
        const SizedBox(height: 5),
        Linkify(
          onOpen: _onOpen,
          text: title,
          style: TextStyle(color: TColor.primary, fontWeight: FontWeight.w700),
        ),
      ],
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
