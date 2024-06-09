import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class SeekingCounterView extends StatefulWidget {
  const SeekingCounterView({super.key});

  @override
  State<SeekingCounterView> createState() => _SeekingCounterViewState();
}

class _SeekingCounterViewState extends State<SeekingCounterView> {
  int sum = GetStorage().read('tawaf');
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
                // curve: Curves.easeIn,
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
                      text: GetStorage().read('tawaf') == null
                          ? "0 : عداد الطواف "
                          : "${GetStorage().read('tawaf')} : عدد الطواف ",
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
                  text: "انقر على الدائرة في كل طواف",
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
                      sum++;
                      circleColor = TColor.primary.withOpacity(0.5);
                    });
                    GetStorage().write('tawaf', sum);
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
              SizedBox(height: media.height * 0.08),
              InkWell(
                onTap: () {
                  setState(() {
                    if (sum > 0) sum = sum - 1;
                  });
                  GetStorage().write('tawaf', sum);
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
                    sum = 0;
                  });
                  GetStorage().write('tawaf', sum);
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
