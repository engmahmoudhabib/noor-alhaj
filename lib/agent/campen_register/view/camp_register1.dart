import 'package:elnoor_emp/agent/campen_register/controller/campen_register_controller.dart';
import 'package:elnoor_emp/agent/campen_register/data/dataSource.dart';
import 'package:elnoor_emp/agent/comon_widgets/icon_primary_button.dart';
import 'package:elnoor_emp/agent/comon_widgets/number_text_field%20copy.dart';
import 'package:elnoor_emp/employee/log_in/views/log_in.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../comon_widgets/custom_drop_search.dart';
import '../../comon_widgets/custom_text_field.dart';

class CampRegister1 extends StatefulWidget {
  const CampRegister1({super.key});

  @override
  State<CampRegister1> createState() => _CampRegister1State();
}

class _CampRegister1State extends State<CampRegister1> {
  CampenRegisterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.off(LogInView());
      },
      child: SafeArea(
          child: Scaffold(
              key: controller.key,
              appBar: AppBar(),
              body: ListView(children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Data.titles.length,
                  itemBuilder: ((context, index) {
                    if (index == 4) {
                      return FadeInLeft(
                        delay: Duration(milliseconds: 700),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: media.width * 0.05),
                              child: const Linkify(
                                  onOpen: _onOpen, text: "رقم الجوال"),
                            ),
                            const SizedBox(height: 11),
                            NumberTextField(
                              controller: controller.phoneNumber,
                              labelText: "  ادخل رقم جوالك",
                            )
                          ],
                        ),
                      );
                    }
                    return FadeInLeft(
                      delay: const Duration(milliseconds: 600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: media.width * 0.05),
                            child: Linkify(
                                onOpen: _onOpen, text: Data.titles[index]),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                              txtController: index == 0
                                  ? controller.firstName
                                  : index == 1
                                      ? controller.fatherName
                                      : index == 2
                                          ? controller.grandName
                                          : index == 3
                                              ? controller.familyName
                                              : index == 5
                                                  ? controller.idNumber
                                                  : TextEditingController(),
                              hintText: Data.hintTitles[index],
                              keyboardType: index == 0 ||
                                      index == 1 ||
                                      index == 2 ||
                                      index == 3
                                  ? TextInputType.name
                                  : index == 4
                                      ? TextInputType.phone
                                      : index == 6
                                          ? TextInputType.number
                                          : TextInputType.emailAddress),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: media.width * 0.05),
                        child: Linkify(
                          onOpen: _onOpen,
                          text: "تاريخ ميلادك",
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField3(
                          txtController: controller.date,
                          hintText: "ادخل تاريخ ميلادك  yyyy-mm-dd",
                          keyboardType: TextInputType.datetime),
                      FadeInLeft(
                          delay: const Duration(milliseconds: 500),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: media.width * 0.05),
                                child: Linkify(onOpen: _onOpen, text: "الجنس"),
                              ),
                              const SizedBox(height: 8),
                              CustomDropSearch(
                                items: Data.gendre,
                                hintText: "اختر الجنس",
                                onChange: (value) {
                                  controller.gender = value;
                                },
                              ),
                            ],
                          )),
                      FadeInLeft(
                          delay: const Duration(milliseconds: 500),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: media.width * 0.05),
                                child: Linkify(
                                    onOpen: _onOpen, text: "خيارات الرحلة"),
                              ),
                              const SizedBox(height: 8),
                              CustomDropSearch(
                                  items: Data.trips,
                                  hintText: "اختر رحلتك",
                                  onChange: (value) {
                                    controller.optionTrip = value;
                                  }),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: media.width * 0.04),
                        child: FadeInLeft(
                          delay: const Duration(milliseconds: 500),
                          child: IconPrimaryButton(
                            onTap: () {
                              if (controller.areFieldsFilled()) {
                                controller.controller.nextPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              } else {
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
                )
              ]))),
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
