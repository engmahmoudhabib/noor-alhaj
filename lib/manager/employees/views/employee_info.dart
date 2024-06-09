import 'package:elnoor_emp/manager/comon_widgets/secondary_button.dart';
import 'package:elnoor_emp/manager/comon_widgets/secondary_button2.dart';
import 'package:elnoor_emp/manager/employees/views/modify_emp_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../user_profile/view/user_profile_view.dart';
import 'add_task.dart';

class EmployeeInfo extends StatefulWidget {
  final int id;
  const EmployeeInfo({
    super.key,
    required this.id,
  });

  @override
  State<EmployeeInfo> createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Linkify(
                onOpen: _onOpen,
                text: "the name ",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Linkify(
                onOpen: _onOpen,
                text: "the number ",
                style: TextStyle(
                  color: TColor.primary,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SecondaryButton2(
                    text: " تعديل",
                    onTap: () {
                      Get.to(() => ModifyEmployee(
                            id: widget.id,
                          ));
                    },
                  ),
                  SizedBox(width: 20),
                  SecondaryButton(
                    text: 'إضافة مهمة',
                    onTap: () {
                      Get.to(() => AddTask(id: widget.id.toString(),));
                    },
                  ),
                ],
              )
            ],
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              Get.to(() => UserProfileView());
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/img/bigAvatar.png"),
            ),
          ),
        ],
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
