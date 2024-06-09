import 'package:elnoor_emp/agent/campen_register/controller/campen_register_controller.dart';
import 'package:elnoor_emp/agent/campen_register/data/dataSource.dart';
import 'package:elnoor_emp/agent/comon_widgets/icon_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../comon_widgets/custom_drop_search.dart';

class CampRegister2 extends StatefulWidget {
  CampRegister2({
    super.key,
  });

  @override
  State<CampRegister2> createState() => _CampRegister2State();
}

class _CampRegister2State extends State<CampRegister2> {
  CampenRegisterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        controller.controller.previousPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: ListView(
            children: [
              FadeInRight(
                  delay: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: media.width * 0.05),
                        child: const Linkify(onOpen: _onOpen, text:"الوظيفة"),
                      ),
                      const SizedBox(height: 8),
                      CustomDropSearch(
                          items: Data.JobPosition,
                          hintText: "اختر الوظيفة",
                          onChange: (value) {
                            controller.job = value;
                          }),
                    ],
                  )),
              // "  "ادخل عنوان سكنك"
              FadeInRight(
                  delay: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: media.width * 0.05),
                        child: const Linkify(onOpen: _onOpen,text: "مكان المسكن"),
                      ),
                      const SizedBox(height: 8),
                      CustomDropSearch(
                          items: Data.address,
                          hintText: "اختر عنوان سكنك",
                          onChange: (value) {
                            controller.address = value;
                          }),
                    ],
                  )),

              FadeInRight(
                  delay: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: media.width * 0.05),
                        child:
                            const Linkify(onOpen: _onOpen,text: "الحالة الاجتماعية"),
                      ),
                      const SizedBox(height: 8),
                      CustomDropSearch(
                          items: Data.social,
                          hintText: "اختر حالتك الاجتماعية",
                          onChange: (value) {
                            controller.social = value;
                          }),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 20, horizontal: media.width * 0.04),
                child: FadeInRight(
                  delay: const Duration(milliseconds: 500),
                  child: IconPrimaryButton(
                    onTap: () {
                      controller.controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                      //  controller.controller.previousPage(
                      //     duration: const Duration(milliseconds: 400),
                      //     curve: Curves.easeInOut);
                    },
                    text: "التالي",
                    icon: Icons.arrow_forward,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunch(link.url)) {
    await launch(link.url);
  } else {
    throw 'Could not launch $link';
  }
}