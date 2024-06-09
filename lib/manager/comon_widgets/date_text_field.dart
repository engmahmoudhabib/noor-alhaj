import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DateTextField extends StatefulWidget {
  final String hintText;
  final String title;
  final TextEditingController txtController;

  DateTextField(
      {super.key,
      required this.hintText,
      required this.txtController,
      required this.title});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(
            right: media.width * 0.05, left: media.width * 0.05, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.003),
              child: Linkify(onOpen: _onOpen, text: widget.title),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              child: TextField(
                readOnly: true,
                textAlign: TextAlign.end,
                controller: widget.txtController,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime(DateTime.now().year - 5), // Five years ago
                    lastDate:
                        DateTime(DateTime.now().year + 10), // Five years later
                  );
                  if (pickedDate != null && pickedDate != DateTime.now()) {
                    String formattedDate =
                        DateFormat('yyyy-M-d').format(pickedDate);
                    widget.txtController.text = formattedDate;
                    print(formattedDate);
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                  // hintTextDirection: TextDirection.ltr,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide()),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: TColor.primary),
                  ),
                ),
              ),
            ),
          ],
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
