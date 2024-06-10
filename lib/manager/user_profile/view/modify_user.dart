import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:elnoor_emp/manager/comon_widgets/custom_text_field.dart';
import 'package:elnoor_emp/manager/comon_widgets/primary_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/api/dio_consumer.dart';
import '../../pilgrims/controller/pilgrim_controller.dart';
import 'package:elnoor_emp/theme.dart';

class ModifyUser extends StatefulWidget {
  final int id;
  const ModifyUser({
    super.key,
    required this.id,
  });

  @override
  State<ModifyUser> createState() => _ModifyUserState();
}

class _ModifyUserState extends State<ModifyUser> {
  final PilgrimController controller =
      Get.put(PilgrimController(api: DioConsumer(dio: Dio())));


  @override
  void initState() {
    super.initState();
    _initializePilgrimData();
  }

 _initializePilgrimData()  {
    Future.delayed(Duration(seconds: 2), () async {
       final pilgrim = await controller.getPilgrim(widget.id);
    setState(() {
      controller.nameController.text = pilgrim.firstName ?? '';
      controller. numberController.text = pilgrim.phonenumber ?? '';
      
     controller.  hotelController.text = pilgrim.hotel ?? '';
      controller. hotelAddController.text = pilgrim.hotelAddress ?? '';
      controller. roomNumController.text = pilgrim.roomNum.toString();
    });
    });
   
  }

  void clearFields() {
    controller. nameController.clear();
    controller. numberController.clear();
    controller. mailController.clear();
    controller. hotelController.clear();
    controller. hotelAddController.clear();
    controller. roomNumController.clear();
  }

  List<String> titles = [
    "الاسم",
    "رقم الجوال",
    "الإيميل",
    "اسم الفندق",
    "عنوان الفندف",
    "رقم الغرفة"
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: FadeInDown(
            delay: Duration(milliseconds: 600),
            child: const Linkify(onOpen: _onOpen, text: 'تعديل الحساب')),
        actions: [
          FadeInRight(
            delay: Duration(milliseconds: 600),
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
      body: Obx(() =>SingleChildScrollView(
        child: controller.isLoading.value == true
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
              : Column(children: [
                  const SizedBox(height: 30),
                  ZoomIn(
                    delay: const Duration(milliseconds: 600),
                    child: const CircleAvatar(
                        maxRadius: 70,
                        backgroundImage:
                            AssetImage("assets/img/bigAvatar.png")),
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                      separatorBuilder: (context, inx) {
                        return SizedBox(height: media.height * 0.02);
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: titles.length,
                      itemBuilder: (context, index) {
                        return FadeInLeft(
                          delay: Duration(milliseconds: 600),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: media.width * 0.05),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Linkify(
                                        onOpen: _onOpen, text: titles[index])),
                              ),
                              CustomTextField(
                                hintText: "",
                                keyboardType: index == 1
                                    ? TextInputType.phone
                                    : TextInputType.name,
                                txtController: (() {
                                  switch (index) {
                                    case 0:
                                      return  controller.nameController;
                                    case 1:
                                      return  controller.numberController;
                                    case 2:
                                      return controller. mailController;
                                    case 3:
                                      return  controller.hotelController;
                                    case 4:
                                      return  controller.hotelAddController;
                                    case 5:
                                      return  controller.roomNumController;
                                    default:
                                      return TextEditingController(); // or any other default controller
                                  }
                                })(),
                              )
                            ],
                          ),
                        );
                      }),
                  ZoomIn(
                    delay: Duration(milliseconds: 600),
                    curve: Curves.decelerate,
                    child: PrimaryButton(
                        onTap: () {
                          controller.updatePilgrim(widget.id);
                        },
                        text: "حفظ"),
                  ),
                ]),
      ),)
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
