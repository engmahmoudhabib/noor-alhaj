import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTab1 extends StatefulWidget {
  String hotel;
  String hotelAddress;
  String numberOfRoom;
  ProfileTab1(
      {super.key,
      required this.hotel,
      required this.hotelAddress,
      required this.numberOfRoom});

  @override
  State<ProfileTab1> createState() => _ProfileTab1State();
}

class _ProfileTab1State extends State<ProfileTab1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding:
            const EdgeInsets.only(top: 10, left: 20, bottom: 25, right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: TColor.black.withOpacity(0.1), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Linkify(
                  onOpen: _onOpen,
                  text: widget.hotel,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: TColor.primary,
                    ),
                    Icon(
                      Icons.star,
                      color: TColor.primary,
                    ),
                    Icon(
                      Icons.star,
                      color: TColor.primary,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Linkify(onOpen: _onOpen, text: widget.hotelAddress),
                    Icon(
                      Icons.location_on,
                      color: TColor.primary,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Linkify(
                        onOpen: _onOpen,
                        text: " الغرفة ${widget.numberOfRoom}"),
                    Icon(
                      Icons.roofing_outlined,
                      color: TColor.primary,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: TColor.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(30)),
              child: CircleAvatar(
                backgroundColor: TColor.white,
                child: const Icon(
                  Icons.house_outlined,
                  color: TColor.primary,
                ),
                // backgroundImage:
                //     AssetImage("assets/img/hotel.png"),
              ),
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
