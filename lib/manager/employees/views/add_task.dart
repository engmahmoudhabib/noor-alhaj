import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/manager/employees/controller/employee_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../comon_widgets/custom_text_field.dart';

import '../../comon_widgets/primary_button.dart';
import 'package:elnoor_emp/theme.dart';

class AddTask extends StatefulWidget {
  final String id;
  const AddTask({super.key, required this.id});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final controller = Get.put(EmployeeController());
  clearText() {
    controller.taskName.clear();
    controller.taskContent.clear();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          FadeInRight(
            delay: const Duration(milliseconds: 500),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Image.asset(
                  "assets/img/whiteArr.png",
                  color: TColor.black,
                )),
          )
        ],
        title: FadeInDown(
            delay: const Duration(milliseconds: 800),
            child: const Linkify(onOpen: _onOpen, text: 'إضافة مهمة')),
      ),
      body: GetBuilder<EmployeeController>(
          init: EmployeeController(),
          builder: (controller) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    FadeInRight(
                      delay: const Duration(milliseconds: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: media.width * 0.05),
                            child: const Linkify(
                                onOpen: _onOpen, text: " عنوان المهمة"),
                          ),
                          const SizedBox(height: 11),
                          CustomTextField(
                            txtController: controller.taskName,
                            hintText: "عنوان المهمة",
                            keyboardType: TextInputType.name,
                          ),
                        ],
                      ),
                    ),
                    FadeInLeft(
                      delay: const Duration(milliseconds: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: media.width * 0.05),
                            child: const Linkify(
                                onOpen: _onOpen, text: "  محتوي المهمة"),
                          ),
                          // const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              controller: controller.taskContent,
                              maxLines: 6,
                              decoration: InputDecoration(
                                hintText: "محتوى المهمة",
                                hintTextDirection: TextDirection.ltr,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: TColor.primary)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  Obx(() =>  ZoomIn(
                        curve: Curves.linear,
                        delay: const Duration(milliseconds: 650),
                        child:controller.isLoadingTask.value?Center(child: CircularProgressIndicator(),): PrimaryButton(
                            onTap: () {
                              controller.addTask(widget.id);
                              clearText();
                             
                           
                            },
                            text: "اضف")))
                  ],
                ),
              ),
            );
          }),
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
