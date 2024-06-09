import 'package:dropdown_search/dropdown_search.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDropSearch extends StatelessWidget {
  List<String> items;
  final String hintText;
  Function onChange;
  CustomDropSearch(
      {super.key,
      required this.items,
      required this.hintText,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(
            right: media.width * 0.05, left: media.width * 0.05, bottom: 20),
        child: SizedBox(
          // height: 50,
          child: DropdownSearch<String>(
            onChanged: (value) => onChange(value),
            items: items,
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) {
                return Container(
                  alignment: Alignment.centerRight,
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    trailing: Linkify(
                      onOpen: _onOpen,
                      text: item,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                );
              },
              menuProps: MenuProps(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              textAlign: TextAlign.start,
              dropdownSearchDecoration: InputDecoration(
                label: Linkify(
                  onOpen: _onOpen,
                  textDirection: TextDirection.rtl,
                  text: hintText,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: TColor.primary)),
                // suffix: Text("dfdfdf"),
              ),
            ),
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
