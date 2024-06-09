import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:elnoor_emp/manager/chat/views/chat_user.dart';
import 'package:elnoor_emp/manager/pilgrims/controller/pilgrim_controller.dart';
import 'package:elnoor_emp/splash_acreen/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../comon_widgets/search_bar.dart';
import '../../comon_widgets/secondary_button.dart';
import '../../comon_widgets/secondary_button2.dart';
import '../../core/api/dio_consumer.dart';
import 'package:elnoor_emp/theme.dart';
import '../../user_profile/view/modify_user.dart';
import '../../user_profile/view/user_profile_view.dart';

class PilgrimView extends StatefulWidget {
  const PilgrimView({Key? key}) : super(key: key);

  @override
  State<PilgrimView> createState() => _PilgrimViewState();
}

class _PilgrimViewState extends State<PilgrimView> {
  final PilgrimController controller =
      Get.put(PilgrimController(api: DioConsumer(dio: Dio())));

  @override
  void initState() {
    super.initState();
    controller.isLoading.value = true;
    controller.fetchPilgrims().then((_) {
      controller.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: FadeInDown(
            delay: const Duration(milliseconds: 600),
            child: const Linkify(
              onOpen: _onOpen,
              text: 'الحجاج',
            )),
        actions: [
          InkWell(
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
              child: Icon(
                Icons.logout,
                color: Colors.black,
              )),
          SizedBox(
            width: 25,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            FadeInRight(
                delay: const Duration(milliseconds: 600),
                child: CustomSearchBar(
                  controller: controller.searchName,
                  whenComplete: () {
                    controller.searchPilgrims(controller.searchName.text);
                  },
                )),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: TColor.primary,
                ));
              } else if (controller.filteredPilgrims.isEmpty) {
                return Center(
                    child: Linkify(
                        onOpen: _onOpen, text: 'لا يوجد حجاج'));
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.filteredPilgrims.length,
                      itemBuilder: ((context, index) {
                        var data = controller.filteredPilgrims[index];
                        return FadeInLeft(
                            delay: const Duration(milliseconds: 600),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              data.lastStep != null
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.only(
                                                              left: 40),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.18,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.03,
                                                        decoration: BoxDecoration(
                                                            color: TColor
                                                                .black
                                                                .withOpacity(
                                                                    0.05),
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        28))),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Linkify(
                                                              onOpen: _onOpen,
                                                              text:
                                                                  data.lastStep ??
                                                                      '',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green
                                                                      .shade400),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox.shrink(),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                height: 25,
                                                child: Linkify(
                                                  onOpen: _onOpen,
                                                  text:
                                                      "${data.firstName} ${data.fatherName} ${data.lastName}",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: TColor.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Linkify(
                                            onOpen: _onOpen,
                                            text: data.phonenumber ?? '',
                                            style: TextStyle(
                                              color: TColor.black
                                                  .withOpacity(0.4),
                                              fontSize: 11,
                                            ),
                                          ),
                                          Linkify(
                                            onOpen: _onOpen,
                                            text: data.hotel ?? '',
                                            style: const TextStyle(
                                                color: TColor.primary,
                                                fontSize: 9),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              SecondaryButton2(
                                                text: "تعديل",
                                                onTap: () {
                                                  Get.to(() => ModifyUser(
                                                        id: data.id ?? 0,
                                                      ));
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              SecondaryButton(
                                                text: 'دردشة',
                                                onTap: () {
                                                  GetStorage().write('chatid',
                                                      data.guideChat);
                                                  Get.to(() => UserChat(
                                                        image:
                                                            data.image ?? '',
                                                        name:
                                                            data.firstName ??
                                                                '',
                                                      ));
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {
                                          controller.getPilgrim(data.id ?? 0);
                                          Get.to(
                                              () => const UserProfileView());
                                        },
                                        child: Stack(
                                          children: [
                                            (data.notes != null &&
                                                    data.notes!.isNotEmpty)
                                                ? CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    child: CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(data
                                                              .image
                                                              .toString()),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: 30,
                                                    // backgroundColor: Colors.blue,
                                                    child: CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(data
                                                              .image
                                                              .toString()),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  if (data.notes != null &&
                                      data.notes!.isNotEmpty)
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                              0.45,
                                      child: SecondaryButton(
                                        text: 'عرض الملاحظات',
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Obx(
                                                () => AlertDialog(
                                                  title: Text('ملاحظات الحاج'),
                                                  content: SizedBox(
                                                    height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .height *
                                                        0.5,
                                                    width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        0.85,
                                                    child: controller
                                                            .isLoading.value
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : ListView.builder(
                                                            itemCount: data
                                                                .notes!.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return ListTile(
                                                                title: Text(data
                                                                        .notes![
                                                                            index]
                                                                        .content ??
                                                                    ''),
                                                                trailing:
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          controller.deleteNoteById(
                                                                              data.notes![index].id.toString());
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Colors.red,
                                                                        )),
                                                              );
                                                            },
                                                          ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('إغلاق'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ));
                      })),
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
  if (await canLaunch(link.url)) {
    await launch(link.url);
  } else {
    throw 'Could not launch $link';
  }
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Linkify(
          onOpen: _onOpen,
          text: 'تسجيل الخروج',
          textAlign: TextAlign.center,
        ),
        content: Linkify(
          onOpen: _onOpen,
          text: 'هل انت متأكد من تسجيل الخروج ؟',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Linkify(onOpen: _onOpen, text: 'إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              // Clear all GetX storage data
                      GetStorage().remove("id",);
      GetStorage().remove("refresh", );
      GetStorage().remove("access", );
      GetStorage().remove("username",);
      GetStorage().remove("pilgramId", );
      GetStorage().remove("ManagerChatId", );
      GetStorage().remove("guideChatId", );
      GetStorage().remove("userType", );
      GetStorage().remove('tawaf', );
      GetStorage().remove('saee', );
              // Navigate to SplashScreen
              Get.offAll(SplashScreen());
            },
            child: Linkify(onOpen: _onOpen, text: 'موافق'),
          ),
        ],
      );
    },
  );
}
