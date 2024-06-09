import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/guide/user_profile/userprofileController/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loginController controller = Get.put(loginController());

  @override
  void initState() {
    super.initState();
    // Delay the refresh token call to ensure it's not within the build phase
    Future.delayed(Duration.zero, () {
      controller.refreshToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/bg.png"),
              alignment: Alignment.bottomCenter),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 200),
              ZoomIn(
                  curve: Curves.easeInCirc,
                  delay: const Duration(milliseconds: 2500),
                  child: const Image(image: AssetImage("assets/img/logo.png"))),
              MaterialButton(
                  onPressed: () {},
                  child: const Linkify(onOpen: _onOpen, text: ""))
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
