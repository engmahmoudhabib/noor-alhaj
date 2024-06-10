// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/manager/employees/views/modify_emp_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../comon_widgets/search_bar.dart';
import '../../comon_widgets/secondary_button.dart';
import '../../comon_widgets/secondary_button2.dart';
import 'package:elnoor_emp/theme.dart';
import '../controller/employee_controller.dart';
import 'add_task.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({super.key});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  final controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: FadeInDown(
          delay: Duration(milliseconds: 600),
          child: const Linkify(onOpen: _onOpen, text: 'الموظفين'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            FadeInRight(
              delay: Duration(milliseconds: 600),
              child: CustomSearchBar(
                controller: controller.searchName,
                whenComplete: () {
                  setState(() {}); // Ensure UI updates on search complete
                },
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: TColor.primary,
                  ),
                );
              } else if (controller.filteredEmployees.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredEmployees.length,
                  itemBuilder: (context, index) {
                    var data = controller.filteredEmployees[index];
                    return FadeInLeft(
                      delay: Duration(milliseconds: 600),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Linkify(
                                  onOpen: _onOpen,
                                  text: data.username,
                                  style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SecondaryButton2(
                                      text: " تعديل",
                                      onTap: () {
                                        Get.to(() => ModifyEmployee(id: data.id));
                                      },
                                    ),
                                    SizedBox(width: 20),
                                    SecondaryButton(
                                      text: 'إضافة مهمة',
                                      onTap: () {
                                        Get.to(() => AddTask(id: data.id.toString()));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                // Navigate to user profile view
                              },
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage("assets/img/bigAvatar.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ],
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
