import 'package:flutter/material.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({super.key, required this.text, required this.onTap});
  final String text;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          decoration: BoxDecoration(
              color: TColor.primary, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Linkify(
                onOpen: _onOpen,
                text: text,
                style: TextStyle(color: TColor.white),
              ),
              const SizedBox(width: 5),
              Icon(
               text == 'عرض الملاحظات'? Icons.check: Icons.message,
                color: TColor.white,
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
