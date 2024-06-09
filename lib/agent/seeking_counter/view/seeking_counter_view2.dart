// ignore_for_file: prefer_const_constructors

import 'dart:ffi';
import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class SeekingCounterView2 extends StatefulWidget {
  const SeekingCounterView2({super.key});

  @override
  State<SeekingCounterView2> createState() => _SeekingCounterView2State();
}

class _SeekingCounterView2State extends State<SeekingCounterView2> {
  int sum1 = GetStorage().read('saee');
  Color circleColor = TColor.primary;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDownBig(
                delay: Duration(milliseconds: 700),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(25)),
                    child: Linkify(
                      onOpen: _onOpen,
                      text: GetStorage().read('saee') == null
                          ? "0 : عداد السعي "
                          : "${GetStorage().read('saee')} : عداد السعي ",
                      style: const TextStyle(
                          color: TColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              ZoomIn(
                delay: Duration(milliseconds: 700),
                child: Linkify(
                  onOpen: _onOpen,
                  text: "انقر على الدائرة في كل سعي",
                  style: TextStyle(
                      color: TColor.black.withOpacity(0.5), fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ZoomIn(
                delay: Duration(milliseconds: 800),
                curve: Curves.easeInOutExpo,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      sum1++;
                      circleColor = TColor.primary
                          .withOpacity(0.5); // Change color on click
                    });
                    GetStorage().write('saee', sum1);
                    Future.delayed(Duration(milliseconds: 200), () {
                      setState(() {
                        circleColor =
                            TColor.primary; // Revert color after delay
                      });
                    });
                  },
                  child: CircleAvatar(
                    radius: 120,
                    backgroundColor: circleColor,
                    backgroundImage: AssetImage("assets/img/weather_rec1.png"),
                  ),
                ),
              ),
              SizedBox(height: media.height * 0.05),
              InkWell(
                onTap: () {
                  setState(() {
                    if (sum1 > 0) sum1 = sum1 - 1;
                  });
                  GetStorage().write('saee', sum1);
                },
                child: FadeInUp(
                  delay: Duration(milliseconds: 500),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(25)),
                    child: Linkify(
                      onOpen: _onOpen,
                      text: "العودة خطوة للوراء",
                      style: const TextStyle(
                          color: TColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    sum1 = 0;
                  });
                  GetStorage().write('saee', sum1);
                },
                child: FadeInUp(
                  delay: Duration(milliseconds: 500),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(25)),
                    child: Linkify(
                      onOpen: _onOpen,
                      text: "إعادة ضبط العداد",
                      style: const TextStyle(
                          color: TColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              Spacer()
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
