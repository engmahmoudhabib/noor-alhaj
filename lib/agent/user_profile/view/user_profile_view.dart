// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../../comon_widgets/custom_app_bar2.dart';
import '../../comon_widgets/profile_tab_button.dart';
import 'package:elnoor_emp/theme.dart';
import '../../widgets/profile_tab_1.dart';
import '../../widgets/profile_tab_2.dart';
import '../controller/profile_controller.dart';
import '../model/user_info_model.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  bool isTurn = true;
  ProfileController controller = Get.put(ProfileController());

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
                    padding: EdgeInsets.all(8.0),
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
                child: FutureBuilder<UserInfoModel>(
                  future: controller.fetchPilgremInfo(),
                  builder: (context, snapshot) {
                    UserInfoModel? data = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: TColor.primary,
                      ));
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Linkify(
                              onOpen: _onOpen,
                              text: 'Error: ${snapshot.error}'));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 80),
                            FadeInLeft(
                              curve: Curves.linear,
                              delay: Duration(milliseconds: 500),
                              child: Linkify(
                                onOpen: _onOpen,
                                //ddfdfd
                                text:
                                    "${data!.firstName}  ${data.fatherName} ${data.lastName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: media.width * 0.05),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInRight(
                              delay: Duration(milliseconds: 500),
                              curve: Curves.linear,
                              child: Linkify(
                                onOpen: _onOpen,
                                text: "${data.phonenumber}",
                                style: TextStyle(
                                    color: TColor.primary,
                                    fontSize: media.width * 0.04),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FadeInLeft(
                                  delay: Duration(milliseconds: 650),
                                  curve: Curves.linear,
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
                                  curve: Curves.linear,
                                  delay: Duration(milliseconds: 500),
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
                                  delay: Duration(milliseconds: 500),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          bottom: 25,
                                          right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                TColor.black.withOpacity(0.1),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Linkify(
                                                onOpen: _onOpen,
                                                text: "${data.hotel}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: TColor.primary,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: TColor.primary,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: TColor.primary,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Linkify(
                                                      onOpen: _onOpen,
                                                      text:
                                                          "${data.hotelAddress}"),
                                                  Icon(
                                                    Icons.location_on,
                                                    color: TColor.primary,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Linkify(
                                                      onOpen: _onOpen,
                                                      text: "${data.roomNum}"
                                                          .toString()),
                                                  Icon(
                                                    Icons.roofing_outlined,
                                                    color: TColor.primary,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: TColor.black
                                                        .withOpacity(0.1)),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: CircleAvatar(
                                              backgroundColor: TColor.white,
                                              child: const Icon(
                                                Icons.house_outlined,
                                                color: TColor.primary,
                                              ),
                                              // backgroundImage:boarding_time
                                              //     AssetImage("assets/img/hotel.png"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            if (!isTurn)
                              FadeInUpBig(
                                  delay: Duration(milliseconds: 500),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          bottom: 30,
                                          right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                TColor.black.withOpacity(0.1),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Linkify(
                                                    onOpen: _onOpen,
                                                    text: "التاريخ",
                                                    style: TextStyle(
                                                        color: TColor.black
                                                            .withOpacity(0.4),
                                                        fontSize: 20),
                                                  ),
                                                  //here will be the date of the trape from the back
                                                  Linkify(
                                                      onOpen: _onOpen,
                                                      text: data.flightDate ??''
                                                         ),
                                                ],
                                              ),
                                              Container(
                                                width: 50,
                                                height: 50,
                                                child: Image(
                                                  image: NetworkImage(
                                                    data.companyLogo ??'',
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Linkify(
                                                    onOpen: _onOpen,
                                                    text: "رقم الرحلة",
                                                    style: TextStyle(
                                                        color: TColor.black
                                                            .withOpacity(0.4),
                                                        fontSize: 20),
                                                  ),
                                                  //here will be the date of the trape from the back arrival
                                                  Linkify(
                                                      onOpen: _onOpen,
                                                      text: "${data.flightNum}"
                                                          .toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Divider(),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Linkify(
                                                    onOpen: _onOpen,
                                                    text: "${data.fromCity}",
                                                    style: TextStyle(
                                                        color: TColor.primary,
                                                        fontSize: 22),
                                                  ),
                                                  Linkify(
                                                    onOpen: _onOpen,
                                                    text: "المغادرة",
                                                    style: TextStyle(
                                                        color: TColor.black
                                                            .withOpacity(0.4),
                                                        fontSize: 19),
                                                  ),
                                                  Linkify(
                                                      onOpen: _onOpen,
                                                      text:
                                                          "${data.departure}"),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .connecting_airports_rounded,
                                                    color: TColor.primary,
                                                    size: 40,
                                                  ),
                                                  Linkify(
                                                    onOpen: _onOpen,
                                                    text: "وقت الرحلة",
                                                    style: TextStyle(
                                                        color: TColor.black
                                                            .withOpacity(0.4),
                                                        fontSize: 20),
                                                  ),
                                                  Linkify(
                                                      onOpen: _onOpen,
                                                      text: "${data.duration}"
                                                          .toString()),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Linkify(
                                                    onOpen: _onOpen,
                                                    text: "${data.toCity}",
                                                    style: TextStyle(
                                                        color: TColor.primary,
                                                        fontSize: 22),
                                                  ),
                                                  Linkify(
                                                    onOpen: _onOpen,
                                                    text: "الوصول",
                                                    style: TextStyle(
                                                        color: TColor.black
                                                            .withOpacity(0.4),
                                                        fontSize: 19),
                                                  ),
                                                  Linkify(
                                                      onOpen: _onOpen,
                                                      text: "${data.arrival}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Divider(),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Linkify(
                                                    onOpen: _onOpen,
                                                    text: "رقم البوابة",
                                                    style: TextStyle(
                                                        color: TColor.black
                                                            .withOpacity(0.4),
                                                        fontSize: 19),
                                                  ),
                                                  Linkify(
                                                      onOpen: _onOpen,
                                                      text: "${data.gateNum}"),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Linkify(
                                                    onOpen: _onOpen,
                                                    text: " وقت الصعود",
                                                    style: TextStyle(
                                                        color: TColor.black
                                                            .withOpacity(0.4),
                                                        fontSize: 19),
                                                  ),
                                                  Linkify(
                                                      onOpen: _onOpen,
                                                      text:
                                                          "${data.boardingTime ?? ''}"
                                                              .toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Divider(),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (data.status ?? false)
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 2,
                                                        horizontal: 15),
                                                    decoration: BoxDecoration(
                                                        color: Colors.black12,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: const Linkify(
                                                      onOpen: _onOpen,
                                                      text: "في الموعد",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                ),
                                              Linkify(
                                                onOpen: _onOpen,
                                                text: "  الحالة",
                                                style: TextStyle(
                                                    color: TColor.black
                                                        .withOpacity(0.4),
                                                    fontSize: 19),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 130,
              child: ZoomIn(
                delay: Duration(milliseconds: 600),
                child: Obx(() {
                  return controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : CircleAvatar(
                          maxRadius: 70,
                          backgroundImage: controller.imagePath.value == null
                              ? AssetImage("assets/img/bg.png")
                                  as ImageProvider<Object>?
                              : (Uri.tryParse(controller.imagePath.value!)
                                          ?.isAbsolute ==
                                      true
                                  ? NetworkImage(controller.imagePath.value!)
                                  : FileImage(File(controller.imagePath
                                      .value!))) as ImageProvider<Object>?,
                        );
                }),
              ),
            ),
            Positioned(
              top: 190,
              right: 131,
              child: ZoomIn(
                delay: Duration(milliseconds: 500),
                child: InkWell(
                  onTap: () {
                    controller.uploadImage();
                  },
                  child: const CircleAvatar(
                    radius: 15,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: TColor.primary,
                      size: 20,
                    ),
                  ),
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
