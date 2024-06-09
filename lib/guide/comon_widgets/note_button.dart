import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../add_note/views/add_note.dart';

class NoteButton extends StatelessWidget {
  int id;
  NoteButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(AddNote(id: id));
        },
        child: Wrap(children: [
          Container(
            // width: MediaQuery.of(context).size.width * 0.2,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                color: TColor.primary, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Linkify(
                  onOpen: _onOpen,
                  text: "إضافة ملاحظة",
                  style: TextStyle(color: TColor.white),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.add,
                  color: TColor.white,
                ),
              ],
            ),
          ),
        ]));
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
