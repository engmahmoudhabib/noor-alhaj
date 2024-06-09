import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/guide/choose_client/views/choose_client.dart';
import 'package:elnoor_emp/guide/comon_widgets/primary_button.dart';
import 'package:elnoor_emp/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class VerficationDone extends StatelessWidget {
  String content;
  VerficationDone({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/bg.png"),
              alignment: Alignment.bottomCenter),
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              FadeInDown(
                delay: const Duration(milliseconds: 500),
                child: const Image(
                  image: AssetImage("assets/img/logo.png"),
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(height: 40),
              FadeInLeft(
                delay: Duration(milliseconds: 500),
                child: Linkify(
                  onOpen: _onOpen,
                  text: "  شكرا لك",
                  style: TextStyle(
                      color: TColor.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: media.width * 0.055),
                ),
              ),
              const SizedBox(height: 10),
              FadeInRight(
                delay: Duration(milliseconds: 700),
                child: Linkify(
                  onOpen: _onOpen,
                  text: content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              Image(image: AssetImage("assets/img/data_done.png")),
              SizedBox(height: MediaQuery.of(context).size.width * 0.3),
              PrimaryButton(
                  onTap: () {
                    Get.off(ChooseClient());
                  },
                  text: "عودة الي الرئيسية")
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
