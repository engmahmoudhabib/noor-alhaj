import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/guide/add_note/add_note_controller/addNoteController.dart';
import 'package:elnoor_emp/guide/comon_widgets/primary_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class AddNote extends StatefulWidget {
  int id;
  AddNote({super.key, required this.id});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  AddNoteController controller = Get.put(AddNoteController());
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FadeInDownBig(
            delay: Duration(milliseconds: 650),
            child: const Linkify(onOpen: _onOpen, text: 'إضافة ملاحظة')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(right: 17),
                child: ZoomIn(
                  curve: Curves.linear,
                  delay: Duration(milliseconds: 500),
                  child: Linkify(
                    onOpen: _onOpen,
                    text: "محتوى الملاحظة",
                    style: TextStyle(fontSize: media.width * 0.05),
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: FadeInRight(
                  delay: Duration(milliseconds: 500),
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    controller: controller.content,
                    maxLines: 9,
                    decoration: InputDecoration(
                      hintText: "محتوى الملاحظة",
                      hintTextDirection: TextDirection.rtl,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInLeft(
                  delay: Duration(milliseconds: 500),
                  child: PrimaryButton(
                      onTap: () {
                        controller.id = widget.id;
                        controller.sendNote(widget.id);
                      },
                      text: "اضف"))
            ],
          ),
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
