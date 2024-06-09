// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/manager/comon_widgets/custom_text_field.dart';
import 'package:elnoor_emp/manager/comon_widgets/primary_button.dart';
import 'package:elnoor_emp/manager/employees/controller/employee_controller.dart';
import 'package:elnoor_emp/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../comon_widgets/number_text_field.dart';
import '../../comon_widgets/password_custome_text_field.dart';

class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({super.key});

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  final controller = Get.put(EmployeeController());
  clearText() {
    controller.nameController.clear();
    controller.numController.clear();
    controller.passController.clear();
    controller.mailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: FadeInDown(
            delay: Duration(milliseconds: 700),
            child: const Linkify(onOpen: _onOpen, text: 'إضافة موظف ')),
        centerTitle: true,
        actions: [
          FadeInRight(
            delay: Duration(milliseconds: 500),
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
      ),
      body: GetBuilder<EmployeeController>(
          init: EmployeeController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  FadeInLeft(
                    delay: Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * 0.05),
                          child:
                              const Linkify(onOpen: _onOpen, text: "  الاسم"),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                            txtController: controller.nameController,
                            hintText: "ادخل الاسم",
                            keyboardType: TextInputType.name)
                      ],
                    ),
                  ),
                  FadeInRight(
                    delay: Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * 0.05),
                          child:
                              const Linkify(onOpen: _onOpen, text: "  حسابك"),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                            txtController: controller.mailController,
                            hintText: "ادخل حسابك",
                            keyboardType: TextInputType.emailAddress)
                      ],
                    ),
                  ),
                  FadeInRight(
                    delay: Duration(milliseconds: 500),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * 0.05),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: const Linkify(
                                  onOpen: _onOpen, text: "رقم الجوال")),
                        ),
                        const SizedBox(height: 11),
                        CustomTextField(
                            hintText: "ادخل رقم جوالك",
                            keyboardType: TextInputType.phone,
                            txtController: controller.numController),
                      ],
                    ),
                  ),
                  FadeInLeft(
                    delay: Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * 0.05),
                          child: const Linkify(
                              onOpen: _onOpen, text: " كلمة المرور"),
                        ),
                        const SizedBox(height: 10),
                        PasswordCustomTextField(
                            secure: true,
                            controller: controller.passController,
                            hintText: "ادخل  كلمة المرور",
                            keyboardType: TextInputType.text),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ZoomIn(
                      delay: Duration(milliseconds: 600),
                      curve: Curves.linear,
                      child: controller.isLoading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : PrimaryButton(
                              onTap: () {
                                controller.addEmployee();
                                clearText();
                                print(controller.isAdded);
                              },
                              text: 'أضف')),
                ],
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
