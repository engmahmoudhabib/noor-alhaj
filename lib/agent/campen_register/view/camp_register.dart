import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/campen_register/controller/campen_register_controller.dart';
import 'package:elnoor_emp/agent/core/api/dio_consumer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';  

class CampRegister extends StatefulWidget {
  const CampRegister({super.key});

  @override
  State<CampRegister> createState() => _CampRegisterState();
}

class _CampRegisterState extends State<CampRegister> {

  // CampenRegisterController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CampenRegisterController>(
      init: CampenRegisterController(api: DioConsumer(dio:Dio())),
      builder: (controller) {
        return SafeArea(
              child: Stack(
        children: [
          PageView.builder( 
            physics: NeverScrollableScrollPhysics(),
            controller: controller.controller ,
            onPageChanged: (index) {
              controller.onPageChanged(index);
            },
            itemCount:  controller.pages.length,
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: [
                  Expanded(
                    child:  controller.pages[index],
                  ),
                ],
              );
            },
          ),
        ],
              ),
            );
  
      },
      );
    
  }
}