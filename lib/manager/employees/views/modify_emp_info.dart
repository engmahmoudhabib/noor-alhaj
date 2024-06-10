import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../comon_widgets/custom_text_field.dart';
import '../../comon_widgets/primary_button.dart';
import 'package:elnoor_emp/theme.dart';
import '../controller/employee_controller.dart';

class ModifyEmployee extends StatefulWidget {
  final int id;
  const ModifyEmployee({
    super.key,
    required this.id,
  });

  @override
  State<ModifyEmployee> createState() => _ModifyEmployeeState();
}

class _ModifyEmployeeState extends State<ModifyEmployee> {
  final controller = Get.put(EmployeeController());

  @override
  void initState() {
    super.initState();
    // Fetch employee data when the widget is initialized
    controller.getEmployee(widget.id).then((_) {
      setState(() {});
    });
  }

  clearFields() {
    controller.updatedEmpnameController.clear();
    controller.updatedEmpnumController.clear();
    controller.updatedEmpmailController.clear();
    controller.updatedEmppassController.clear();
  }

  List<String> titles = ["الاسم", "رقم الجوال", "الإيميل", "كلمة السر"];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: FadeInDown(
            delay: Duration(milliseconds: 500),
            child: const Linkify(onOpen: _onOpen, text: 'تعديل بيانات الموظف')),
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
      body: controller.employee.value == null
          ? Center(
              child: CircularProgressIndicator(),
            ) // Show loading indicator while fetching data
          : SingleChildScrollView(
              child: GetBuilder<EmployeeController>(
                  init: EmployeeController(),
                  builder: (controller) {
                    return Column(children: [
                      SizedBox(
                        height: media.width * 0.2,
                      ),
                      ListView.separated(
                          separatorBuilder: (context, inx) {
                            return SizedBox(height: 15);
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: titles.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: media.width * 0.05),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Linkify(
                                          onOpen: _onOpen,
                                          text: titles[index])),
                                ),
                                CustomTextField(
                                  hintText: "",
                                  keyboardType: (() {
                                    switch (index) {
                                      case 0:
                                        return TextInputType.name;
                                      case 1:
                                        return TextInputType.phone;
                                      case 2:
                                        return TextInputType.emailAddress;
                                      default:
                                        return TextInputType
                                            .name; // or any other default controller
                                    }
                                  })(),
                                  txtController: (() {
                                    switch (index) {
                                      case 0:
                                        return controller
                                            .updatedEmpnameController;
                                      case 1:
                                        return controller
                                            .updatedEmpnumController;
                                      case 2:
                                        return controller
                                            .updatedEmpmailController;
                                      case 3:
                                        return controller
                                            .updatedEmppassController;
                                      default:
                                        return TextEditingController(); // or any other default controller
                                    }
                                  })(),
                                )
                              ],
                            );
                          }),
                      controller.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : PrimaryButton(
                              onTap: () {
                                controller.updateEmployee(widget.id).then((_) {
                                  clearFields();
                                  Get.dialog(
                                    AlertDialog(
                                      title: Text('نجاح'),
                                      content:
                                          Text('تم تعديل بيانات الموظف بنجاح'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('موافق'),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                              text: "حفظ",
                            ),
                    ]);
                  })),
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
