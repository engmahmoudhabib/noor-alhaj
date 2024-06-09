// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:elnoor_emp/manager/comon_widgets/primary_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../comon_widgets/custom_text_field2.dart';

import '../../core/api/dio_consumer.dart';
import 'package:elnoor_emp/theme.dart';
import '../controller/pilgrim_controller.dart';


class AddNewClient extends StatefulWidget {
  const AddNewClient({super.key});

  @override
  State<AddNewClient> createState() => _AddNewClientState();
}

class _AddNewClientState extends State<AddNewClient> {
  List titles = [
    "الاسم الأول",
    "اسم الأب",
    "اسم الجد",
    "العائلة",
    // "تاريخ الميلاد",
    "رقم الجوال",

    "رقم الرحلة",
    "رقم التذكرة",
    "موعد الوصول",
    "موعد الرحيل",
    "وقت الصعود",
    "رقم البوابة",
    "شركة الطيران",
    "الحالة",
    "الفندق",
    "عنوان الفندق",
    "رقم الغرفة",
    "كلمة المرور"
        "م",
  ];

  final PilgrimController controller =
      Get.put(PilgrimController(api: DioConsumer(dio: Dio())));
  clearFields() {
    controller.nameController.clear();
    controller.fatherController.clear();
    controller.grandFatherController.clear();
    controller.familyController.clear();
    controller.dateController.clear();
    controller.numController.clear();
    controller.flightNumController.clear();
    controller.idController.clear();
    controller.arriveController.clear();
    controller.leaveController.clear();
    controller.boardController.clear();
    controller.gateNumController.clear();
    controller.companyController.clear();
    controller.stateController.clear();
    controller.hotelController.clear();
    controller.hotelAddController.clear();
    controller.roomNumController.clear();
    controller.passController.clear();
    controller.flightDateController.clear();
    controller.fromCityController.clear();
    controller.toCityController.clear();
  }

  var data;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FadeInDown(
            delay: const Duration(milliseconds: 700),
            child: const Text('إضافة حاج ')),
        centerTitle: true,
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
      ),
      body: GetBuilder<PilgrimController>(
          init: PilgrimController(api: DioConsumer(dio: Dio())),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "اسم الأول",
                      txtController: controller.nameController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "اسم الأب",
                      txtController: controller.fatherController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "اسم الجد",
                      txtController: controller.grandFatherController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: " العائلة",
                      txtController: controller.familyController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: " تاريخ المبلاد",
                      txtController: controller.dateController),

                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.phone,
                      title: " رقم جوالك",
                      txtController: controller.numController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.phone,
                      title: " رقم الرحلة",
                      txtController: controller.flightNumController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "   وقت الرحلة",
                      txtController: controller.flightDateController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.phone,
                      title: " رقم الهوية",
                      txtController: controller.idController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "  موعد الوصول",
                      txtController: controller.arriveController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: " موعد الرحيل",
                      txtController: controller.leaveController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "  وقت الصعود",
                      txtController: controller.boardController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.phone,
                      title: "  رقم البوابة",
                      txtController: controller.gateNumController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "  شركة الطيران",
                      txtController: controller.companyController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: " حالة الرحلة",
                      txtController: controller.stateController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: " الفندق ",
                      txtController: controller.hotelController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "  عنوان الفندق",
                      txtController: controller.hotelAddController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.number,
                      title: "  رقم الغرفة",
                      txtController: controller.roomNumController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "  كلمة المرور",
                      txtController: controller.passController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "   المدينة المغادرة",
                      txtController: controller.fromCityController),
                  CustomTextField2(
                      hintText: "",
                      keyboardType: TextInputType.name,
                      title: "   المدينة الوجهة",
                      txtController: controller.toCityController),
                  // CustomTextField2(
                  // hintText: "",
                  // keyboardType: TextInputType.name,
                  // title:"    المرشد",
                  // txtController: controller.guildController),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(""),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(
                  //           horizontal: media.width * 0.05),
                  //       child: Text("المرشد"),
                  //     ),
                  //   ],
                  // ),

                  Padding(
                      padding: EdgeInsets.only(
                          right: media.width * 0.05,
                          left: media.width * 0.05,
                          bottom: 20),
                      child: SizedBox(
                          child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(25)),
                        child: DropdownButton(
                            // style: TextStyle(fontSize: 15),
                            borderRadius: BorderRadius.circular(20),
                            isExpanded: true,
                            padding: const EdgeInsets.all(10),
                            value: data,
                            hint: Text("المرشد"),
                            alignment: Alignment.centerRight,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.guides.map((e) {
                              return DropdownMenuItem(
                                alignment: Alignment.centerRight,
                                value: e.id,
                                child: Text(e.username),
                              );
                            }).toList(),
                            onChanged: (value) {
                              // data = value;
                              controller.numberGuide.value =
                                  int.parse(value.toString());
                              print(value.runtimeType);
                              print(controller.numberGuide.value);
                            }),
                      ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: controller.isLoading == true? Center(child: CircularProgressIndicator(),) :PrimaryButton(
                        onTap: () {
                          // print(controller.nameController.text);
                          // print(controller.fatherController.text);
                          // print(controller.grandFatherController.text);
                          // print(controller.familyController.text);
                          // print(controller.dateController.text);
                          // print(controller.numController.text);
                          // print(controller.flightNumController.text);
                          // print(controller.flightDateController.text);
                          // print(controller.idController.text);
                          // print(controller.arriveController.text);
                          // print(controller.leaveController.text);
                          // print(controller.boardController.text);
                          // print(controller.gateNumController.text);
                          // print(controller.companyController.text);
                          // print(controller.stateController.text);
                          // print(controller.hotelController.text);
                          // print(controller.hotelAddController.text);
                          // print(controller.roomNumController.text);
                          // print(controller.passController.text);
                          // print(controller.fromCityController.text);
                          // print(controller.toCityController.text);
                          controller.createNewOne();

                          // clearFields();
                        },
                        text: "اضف"),
                  ),
                ],
              ),
            );
          }),
    );
  }
}


// ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: titles.length,
                  //     itemBuilder: (context, index) {
                  //       if (index == 5) {
                  //         return DateTextField(
                  //           title: " تاريخ الميلاد",
                  //           hintText: "",
                  //           txtController: controller.dateController,
                  //         );
                  //       }
                  //       return Column(
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: media.width * 0.05),
                  //             child: Text(titles[index]),
                  //           ),
                  //           const SizedBox(height: 10),
                  //           CustomTextField(
                  //             hintText: "",
                  //             keyboardType: (() {
                  //               switch (index) {
                  //                 case 0:
                  //                   return TextInputType.name;
                  //                 case 1:
                  //                   return TextInputType.name;
                  //                 case 2:
                  //                   return TextInputType.name;
                  //                 case 3:
                  //                   return TextInputType.name;
                  //                 case 4:
                  //                   return TextInputType.number;
                  //                 case 5:
                  //                   return TextInputType.phone;
                  //                 case 6:
                  //                   return TextInputType.number;
                  //                 case 7:
                  //                   return TextInputType.number;
                  //                 case 8:
                  //                   return TextInputType.name;
                  //                 case 9:
                  //                   return TextInputType.name;
                  //                 case 10:
                  //                   return TextInputType.name;
                  //                 case 11:
                  //                   return TextInputType.number;
                  //                 case 12:
                  //                   return TextInputType.name;
                  //                 case 13:
                  //                   return TextInputType.name;
                  //                 case 14:
                  //                   return TextInputType.name;
                  //                 case 15:
                  //                   return TextInputType.name;
                  //                 case 16:
                  //                   return TextInputType.number;
                  //                 case 17:
                  //                   return TextInputType.name;

                  //                 default:
                  //                   return TextInputType
                  //                       .name; // or any other default controller
                  //               }
                  //             })(),
                  //             txtController: (() {
                  //               switch (index) {
                  //                 case 0:
                  //                   return controller.nameController;
                  //                 case 1:
                  //                   return controller.fatherController;
                  //                 case 2:
                  //                   return controller.grandFatherController;
                  //                 case 3:
                  //                   return controller.familyController;
                  //                 case 4:
                  //                   return controller.dateController;
                  //                 case 5:
                  //                   return controller.numController;
                  //                 case 6:
                  //                   return controller.flightNumController;
                  //                 case 7:
                  //                   return controller.ticketNumController;
                  //                 case 8:
                  //                   return controller.arriveController;
                  //                 case 9:
                  //                   return controller.leaveController;
                  //                 case 10:
                  //                   return controller.boardController;
                  //                 case 11:
                  //                   return controller.gateNumController;
                  //                 case 12:
                  //                   return controller.companyController;
                  //                 case 13:
                  //                   return controller.stateController;
                  //                 case 14:
                  //                   return controller.hotelController;
                  //                 case 15:
                  //                   return controller.hotelAddController;
                  //                 case 16:
                  //                   return controller.roomNumController;
                  //                 case 17:
                  //                   return controller.passController;

                  //                 default:
                  //                   return TextEditingController(); // or any other default controller
                  //               }
                  //             })(),
                  //           ),
                  //         ],
                  //       );
                  //     }),