import 'package:elnoor_emp/agent/campen_register/controller/campen_register_controller.dart';
import 'package:elnoor_emp/agent/campen_register/data/dataSource.dart';
import 'package:elnoor_emp/agent/comon_widgets/icon_primary_button.dart';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../comon_widgets/custom_drop_search.dart';
import '../../comon_widgets/custom_text_field.dart';

class CampRegister3 extends StatefulWidget {
  CampRegister3({
    super.key,
  });

  @override
  State<CampRegister3> createState() => _CampRegister3State();
}

class _CampRegister3State extends State<CampRegister3> {
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Data.titles2.length,
                itemBuilder: ((context, index) {
                  return FadeInLeft(
                    delay: const Duration(milliseconds: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * 0.05),
                          child: Linkify(
                              onOpen: _onOpen, text: Data.titles2[index]),
                        ),
                        const SizedBox(height: 8),
                        CustomDropSearch(
                          items: Data.Lists[index],
                          hintText: Data.dropHints[index],
                          onChange: (value) {
                            index == 0
                                ? controller.typeAlhajj = value
                                :
                                // index == 1 ? controller.refrence = value :
                                controller.meansJourny = value;
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: media.width * 0.05),
                      child:
                          Linkify(onOpen: _onOpen, text: "اخر سنة حججت فيها"),
                    ),
                    const SizedBox(height: 8),
                    CustomDropSearch(
                      items: controller.years,
                      hintText: "اختر السنة",
                      onChange: (value) {
                        controller.lastYear = value;
                      },
                    ),
                  ],
                ),
              ),
              FadeInLeft(
                delay: Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: media.width * 0.05),
                      child: Linkify(onOpen: _onOpen, text: "مرجع التقليد"),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                        txtController: controller.refrence,
                        hintText: "مرجع التقليد",
                        keyboardType: TextInputType.text),
                  ],
                ),
              ),
              FadeInLeft(
                delay: Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: media.width * 0.05),
                      child: Linkify(onOpen: _onOpen, text: "عدد الحجات"),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                        txtController: controller.goes,
                        hintText: "اكتب عدد الحجات",
                        keyboardType: TextInputType.number),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: media.width * 0.04),
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 500),
                        child: IconPrimaryButton(
                          onTap: () {
                            if (controller.areGood3()) {
                              controller.controller.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            } else {
                              controller.send();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Linkify(
                                        onOpen: _onOpen,
                                        text: 'Please fill in all fields.')),
                              );
                            }
                          },
                          text: "التالي",
                          icon: Icons.arrow_forward,
                        ),
                      ),
                    ),
                  ],
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
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
