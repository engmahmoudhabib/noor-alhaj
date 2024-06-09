import 'package:flutter/material.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTab2 extends StatefulWidget {
  const ProfileTab2({super.key});

  @override
  State<ProfileTab2> createState() => _ProfileTab2State();
}

class _ProfileTab2State extends State<ProfileTab2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding:
            const EdgeInsets.only(top: 10, left: 20, bottom: 30, right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: TColor.black.withOpacity(0.1), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Linkify(
                      onOpen: _onOpen,
                      text: "التاريخ",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 20),
                    ),
                    //here will be the date of the trape from the back
                    const Linkify(onOpen: _onOpen, text: "22/1/2023"),
                  ],
                ),
                const Icon(
                  Icons.abc,
                  size: 50,
                ),
                Column(
                  children: [
                    Linkify(
                      onOpen: _onOpen,
                      text: "رقم الرحلة",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 20),
                    ),
                    //here will be the date of the trape from the back
                    const Linkify(onOpen: _onOpen, text: "2512"),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Linkify(
                      onOpen: _onOpen,
                      text: "JED",
                      style: TextStyle(color: TColor.primary, fontSize: 22),
                    ),
                    Linkify(
                      onOpen: _onOpen,
                      text: "الوصول",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 19),
                    ),
                    Linkify(onOpen: _onOpen, text: "6:00"),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.connecting_airports_rounded,
                      color: TColor.primary,
                      size: 40,
                    ),
                    Linkify(
                      onOpen: _onOpen,
                      text: "رقم الرحلة",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 20),
                    ),
                    const Linkify(onOpen: _onOpen, text: "6:00"),
                  ],
                ),
                Column(
                  children: [
                    const Linkify(
                      onOpen: _onOpen,
                      text: "EGP",
                      style: TextStyle(color: TColor.primary, fontSize: 22),
                    ),
                    Linkify(
                      onOpen: _onOpen,
                      text: "الوصول",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 19),
                    ),
                    Linkify(onOpen: _onOpen, text: "6:00"),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Linkify(
                      onOpen: _onOpen,
                      text: "رقم البوابة",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 19),
                    ),
                    Linkify(onOpen: _onOpen, text: "2B"),
                  ],
                ),
                Column(
                  children: [
                    Linkify(
                      onOpen: _onOpen,
                      text: " وقت الصعود",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 19),
                    ),
                    const Linkify(onOpen: _onOpen, text: "4:50"),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(25)),
                    child: const Linkify(
                      onOpen: _onOpen,
                      text: "في الموعد",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Linkify(
                  onOpen: _onOpen,
                  text: "  الحالة",
                  style: TextStyle(
                      color: TColor.black.withOpacity(0.4), fontSize: 19),
                ),
              ],
            ),
          ],
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
