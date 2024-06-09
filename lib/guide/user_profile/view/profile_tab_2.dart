import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTab2 extends StatefulWidget {
  String flight_num;
  String from_city;
  String to_city;
  String gate_num;
  String company_logo;
  DateTime created;
  String departure;
  String arrival;
  String duration;
  String borading_time;

  ProfileTab2({
    super.key,
    required this.arrival,
    required this.flight_num,
    required this.from_city,
    required this.to_city,
    required this.gate_num,
    required this.created,
    required this.company_logo,
    required this.departure,
    required this.borading_time,
    required this.duration,
  });

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
                    Linkify(
                        onOpen: _onOpen,
                        text:
                            "${widget.created.day}/${widget.created.month}/${widget.created.year}"),
                  ],
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.company_logo))),
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
                    Linkify(onOpen: _onOpen, text: widget.flight_num),
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
                      text: widget.from_city,
                      style: TextStyle(color: TColor.primary, fontSize: 22),
                    ),
                    Linkify(
                      onOpen: _onOpen,
                      text: "المغادرة",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 19),
                    ),
                    Linkify(onOpen: _onOpen, text: "${widget.departure}"),
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
                      text: "وقت الرحلة",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 20),
                    ),
                    Linkify(onOpen: _onOpen, text: "${widget.duration}"),
                  ],
                ),
                Column(
                  children: [
                    Linkify(
                      onOpen: _onOpen,
                      softWrap: true,
                      maxLines: 2,
                      text: widget.to_city,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: TColor.primary, fontSize: 22),
                    ),
                    Linkify(
                      onOpen: _onOpen,
                      text: "الوصول",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 19),
                    ),
                    Linkify(onOpen: _onOpen, text: "${widget.arrival}"),
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
                    Linkify(onOpen: _onOpen, text: widget.gate_num),
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
                    Linkify(onOpen: _onOpen, text: "${widget.borading_time}"),
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
