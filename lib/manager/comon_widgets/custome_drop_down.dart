import 'package:dropdown_search/dropdown_search.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDropSearch extends StatelessWidget {
  List<String> items;
  final String hintText;
  CustomDropSearch({super.key, required this.items, required this.hintText});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(
            right: media.width * 0.05, left: media.width * 0.05, bottom: 20),
        child: SizedBox(
            // height: 50,
            child: DropdownSearch<String>(
          items: items,
          popupProps: PopupProps.menu(
            itemBuilder: (context, item, isSelected) {
              return Container(
                padding: const EdgeInsets.all(5),
                child: ListTile(
                  title: Linkify(
                    onOpen: _onOpen,
                    text: item,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
            menuProps: MenuProps(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            textAlign: TextAlign.end,
            // baseStyle: TextStyle(color: Colors.red),
            dropdownSearchDecoration: InputDecoration(
              hintText: hintText,
              hintTextDirection: TextDirection.ltr,

              // ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: TColor.primary)),
            ),
          ),
        )));
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
