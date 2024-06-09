import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class RejectButton extends StatefulWidget {
  RejectButton({super.key});

  @override
  State<RejectButton> createState() => _RejectButtonState();
}

class _RejectButtonState extends State<RejectButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20)),
      child: const Row(
        children: [
          Linkify(
            onOpen: _onOpen,
            text: "دردشة",
            style: TextStyle(color: TColor.primary),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.message,
            color: TColor.primary,
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
