import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/guide/chat/views/chat_user.dart';
import 'package:elnoor_emp/guide/choose_client/model/pilgrims_model.dart';
import 'package:elnoor_emp/guide/comon_widgets/primary_button.dart';
import 'package:elnoor_emp/guide/user_profile/view/profile_tab_1.dart';
import 'package:elnoor_emp/guide/user_profile/view/profile_tab_2.dart';
import 'package:elnoor_emp/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../comon_widgets/custom_app_bar2.dart';
import '../../comon_widgets/profile_tab_button.dart';

class UserProfileView extends StatefulWidget {
  PilgrimsModel pilgrim;
  UserProfileView({super.key, required this.pilgrim});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  bool isTurn = true;
  // File? image;
  // final imagePicker = ImagePicker();
  // uploadImage() async {
  //   var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       image = File(pickedImage.path);
  //     });
  //   } else {}
  // }
  // final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: media.width * 0.6,
                  decoration: const BoxDecoration(color: TColor.primary),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomAppBar2(),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 170,
              left: 5,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                height: media.width * 1.68,
                width: media.width * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 600),
                        child: Linkify(
                          onOpen: _onOpen,
                          text:
                              "${widget.pilgrim.firstName} ${widget.pilgrim.fatherName} ${widget.pilgrim.lastName}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: media.width * 0.05),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeInRight(
                        delay: const Duration(milliseconds: 600),
                        child: Linkify(
                          onOpen: _onOpen,
                          text: widget.pilgrim.phonenumber ?? "",
                          style: TextStyle(
                              color: TColor.primary,
                              fontSize: media.width * 0.04),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ZoomIn(
                        delay: const Duration(milliseconds: 600),
                        curve: Curves.linear,
                        child: InkWell(
                            onTap: () {},
                            child: widget.pilgrim.active == true
                                ?widget.pilgrim.lastStep == null ? SizedBox.shrink(): Container(
                                    width: media.width * 0.18,
                                    height: media.height * 0.03,
                                    decoration: BoxDecoration(
                                        color: TColor.black.withOpacity(0.05),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(28))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Linkify(
                                          onOpen: _onOpen,
                                          text: widget.pilgrim.lastStep ??
                                              '',
                                          style: TextStyle(
                                              color: Colors.green.shade400),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Container(
                                      width: media.width * 0.18,
                                      height: media.height * 0.03,
                                      decoration: BoxDecoration(
                                          color: TColor.black.withOpacity(0.05),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(28))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Linkify(
                                            onOpen: _onOpen,
                                            text: widget.pilgrim.hajSteps?.last
                                                    .hajStep ??
                                                '',
                                            style: TextStyle(
                                                color: Colors.red.shade400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                      ),
                      const SizedBox(height: 20),
                      ZoomIn(
                          curve: Easing.standardAccelerate,
                          delay: const Duration(milliseconds: 600),
                          child: PrimaryButton(
                              onTap: () {
                                GetStorage()
                                    .write("chatid", widget.pilgrim.guideChat);
                                Get.to(UserChat(
                                  image: widget.pilgrim.image ?? '',
                                  name:
                                      "${widget.pilgrim.firstName} ${widget.pilgrim.fatherName} ${widget.pilgrim.lastName}",
                                ));
                              },
                              text: "دردشة")),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FadeInLeft(
                            delay: const Duration(milliseconds: 600),
                            child: ProfileTabButton(
                              title: "تفاصيل الرحلة",
                              isActive: !isTurn,
                              onpressed: () {
                                setState(() {
                                  isTurn = !isTurn;
                                });
                              },
                            ),
                          ),
                          FadeInRight(
                            delay: const Duration(milliseconds: 600),
                            child: ProfileTabButton(
                              title: " معلومات السكن",
                              isActive: isTurn,
                              onpressed: () {
                                setState(() {
                                  isTurn = !isTurn;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      if (isTurn)
                        FadeInUpBig(
                            delay: const Duration(milliseconds: 600),
                            child: ProfileTab1(
                              hotel: widget.pilgrim.hotel ?? '',
                              hotelAddress: widget.pilgrim.hotelAddress ?? '',
                              numberOfRoom: widget.pilgrim.roomNum.toString(),
                            )),
                      if (!isTurn)
                        FadeInUpBig(
                            delay: const Duration(milliseconds: 600),
                            child: ProfileTab2(
                              arrival: widget.pilgrim.arrival ?? "",
                              borading_time: widget.pilgrim.boardingTime ?? '',
                              company_logo: widget.pilgrim.companyLogo ?? "",
                              created: DateTime.parse(widget.pilgrim.created ??
                                  DateTime.now().toString()),
                              departure: widget.pilgrim.departure ?? '',
                              duration: widget.pilgrim.duration ?? '',
                              flight_num: widget.pilgrim.flightNum.toString(),
                              from_city: widget.pilgrim.fromCity ?? '',
                              to_city: widget.pilgrim.toCity ?? '',
                              gate_num: widget.pilgrim.gateNum.toString(),
                            )),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 130,
              child: ZoomIn(
                curve: Curves.linear,
                delay: const Duration(milliseconds: 600),
                child: CircleAvatar(
                  maxRadius: 70,
                  backgroundImage: NetworkImage(widget.pilgrim.image ?? ''),
                ),
              ),
            ),
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
