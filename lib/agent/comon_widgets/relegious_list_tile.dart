import 'package:flutter/material.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class RelegiousListTile extends StatefulWidget {
  void Function()? onTap;
  final String title;
  final String subTitle;
  final String date;
  final String image;
  RelegiousListTile(
      {super.key,
      required this.onTap,
      required this.title,
      required this.subTitle,
      required this.date,
      required this.image});

  @override
  State<RelegiousListTile> createState() => _RelegiousListTileState();
}

class _RelegiousListTileState extends State<RelegiousListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: TColor.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Linkify(
                  onOpen: _onOpen,
                  text: widget.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Linkify(
                  onOpen: _onOpen,
                  text: widget.subTitle,
                  style: TextStyle(
                      fontSize: 9, color: TColor.black.withOpacity(0.3)),
                ),
                Linkify(
                  onOpen: _onOpen,
                  text: widget.date,
                  style: const TextStyle(color: TColor.primary, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 10),
            // here we will put the image from the api
            Image(image: AssetImage("assets/img/alqublah_mini.png"))
          ],
        ),
        // ListTile(
        //   onTap: () {},
        //   trailing: Image(image: AssetImage("assets/img/alqublah_mini.png")),
        //   title: Text("some text"),
        //   subtitle: Text("lower text"),
        // ),
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
