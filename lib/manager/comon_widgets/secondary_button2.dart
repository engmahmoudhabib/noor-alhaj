import 'package:flutter/material.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondaryButton2 extends StatelessWidget {
  SecondaryButton2({super.key, required this.text, required this.onTap});
  final String text;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Linkify(
                onOpen: _onOpen,
                text: text,
                style: const TextStyle(color: TColor.primary),
              ),
              const SizedBox(width: 5),
              Icon(
                text == " تعديل" || text == "تعديل"? Icons.edit : Icons.message,
                color: TColor.primary,
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
