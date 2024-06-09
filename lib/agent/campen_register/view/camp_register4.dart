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

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CampRegister4 extends StatefulWidget {
  CampRegister4({super.key});

  @override
  State<CampRegister4> createState() => _CampRegister4State();
}

class _CampRegister4State extends State<CampRegister4> {
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
          key: controller.scaffoldkey,
          appBar: AppBar(),
          body: ModalProgressHUD(
            inAsyncCall: controller.showProgress.value,
            child: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Data.titles3.length,
                  itemBuilder: ((context, index) {
                    List<String> item;
                    if (index == 0) {
                      item = Data.bloodType;
                    } else {
                      item = Data.ans;
                    }
                    return FadeInRight(
                      delay: const Duration(milliseconds: 600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: media.width * 0.05),
                            child: Linkify(
                                onOpen: _onOpen, text: Data.titles3[index]),
                          ),
                          const SizedBox(height: 8),
                          CustomDropSearch(
                            items: item,
                            hintText: Data.dropHints2[index],
                            onChange: (value) {
                              index == 0
                                  ? controller.blood = value
                                  : index == 1
                                      ? controller.Diseases = value
                                      : index == 2
                                          ? controller.helpTaoaf = value
                                          : index == 3
                                              ? controller.helpSaae = value
                                              : controller.helpWheelChair =
                                                  value;
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: media.width * 0.05),
                        child: const Linkify(
                            onOpen: _onOpen,
                            text: " يمكنك كتابة المساعدة المطلوبة"),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                          txtController: controller.detail,
                          hintText: "اكتب ما تحتاجه هنا  ",
                          keyboardType: TextInputType.name),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: media.width * 0.04),
                        child: FadeInRight(
                          delay: const Duration(milliseconds: 500),
                          child: IconPrimaryButton(
                            onTap: () {
                              if (controller.areGood4()) {
                                controller.send2();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
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
