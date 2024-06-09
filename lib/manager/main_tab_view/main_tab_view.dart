import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/manager/chat/views/chat_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';

import 'package:elnoor_emp/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pilgrims/views/add_new_client.dart';
import '../pilgrims/views/pilgrim.dart';
import '../employees/views/add_new_employee.dart';
import '../employees/views/employee_view.dart';
import '../notification_/views/add_new_notification.dart';
import '../notification_/views/notification.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = const PilgrimView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageStorage(
            bucket: pageStorageBucket,
            child: currentTabView,
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/img/navBar.png"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectTab = 0;
                                      currentTabView = const PilgrimView();
                                    });
                                  },
                                  icon: Image.asset(
                                    "assets/img/cleintTab.png",
                                    width: 55,
                                    height: 55,
                                    color: selectTab == 0
                                        ? TColor.primary
                                        : TColor.black,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 1;
                                    currentTabView = const EmployeeView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/empTab.png",
                                  width: 55,
                                  height: 55,
                                  color: selectTab == 1
                                      ? TColor.primary
                                      : TColor.black,
                                ),
                              ),
                              const SizedBox(
                                width: 55,
                                height: 55,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 2;
                                    currentTabView = const NotificationView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/notiTab.png",
                                  width: 55,
                                  height: 55,
                                  color: selectTab == 2
                                      ? TColor.primary
                                      : TColor.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 3;
                                    currentTabView = const ChatView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/chatTab.png",
                                  width: 55,
                                  height: 55,
                                  color: selectTab == 3
                                      ? TColor.primary
                                      : TColor.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _showAlertDialog(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                          ),
                          child: Image.asset(
                            "assets/img/add_navBar.png",
                            width: 55,
                            height: 55,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var media = MediaQuery.of(context).size;

      return AlertDialog(
        content: Container(
          height: media.width * 0.73,
          width: media.width * 0.8,
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: 4,
              itemBuilder: ((context, index) {
                List<String> images = [
                  "assets/img/addClientIcon.png",
                  "assets/img/addEmpIcon.png",
                  "assets/img/addNotiIcon.png",
                  "assets/img/chatIcon.png"
                ];
                List<String> titles = [
                  " اضافة حاج ",
                  "اضافة موظف",
                  " اضافة اشعار",
                  " بدء دردشة "
                ];
                return InkWell(
                  onTap: () {
                    if (index == 0) {
                      Get.to(() => const AddNewClient());
                    }
                    if (index == 1) {
                      Get.to(() => const AddNewEmployee());
                    }
                    if (index == 2) {
                      Get.to(() => const NewNotification());
                    }
                    if (index == 3) {
                      Get.to(() => const ChatView());
                    }
                  },
                  child: ZoomIn(
                    delay: const Duration(milliseconds: 300),
                    curve: Easing.legacy,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(images[index]),
                          const SizedBox(height: 10),
                          Linkify(onOpen: _onOpen, text: titles[index]),
                        ],
                      ),
                    ),
                  ),
                );
              })),
        ),
      );
    },
  );
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
