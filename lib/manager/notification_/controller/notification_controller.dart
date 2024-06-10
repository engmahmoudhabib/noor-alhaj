import 'package:dio/dio.dart';
import 'package:elnoor_emp/employee/log_in/model/user_state.dart';
import 'package:elnoor_emp/manager/core/errors/exceptions.dart';
import 'package:elnoor_emp/manager/notification_/model/notification_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/api/end_points.dart';

import '../model/send_succesfully_model.dart';

class NotificationController extends GetxController {
  var dio = Dio(
    BaseOptions(
      baseUrl: EndPoint.baseUrl,
    ),
  );
  final GetStorage storage = GetStorage();
  UserState userState = UserInitial();
  //==================================
  final TextEditingController notiName = TextEditingController();
  final TextEditingController notiContent = TextEditingController();
  //=================================
  NotificationDone? done;
  RxBool isSendDone = false.obs;
  bool isDone = false;
  //=================================

  sendNotification() async {
    var token = storage.read("access");

    try {
      var response = await dio.post(EndPoint.addNotification,
          data: {
            ApiKeys.title: notiName.text,
            ApiKeys.content: notiContent.text,
          },
          options: Options(headers: {
            ApiKeys.auth: "Bearer $token",
          }));
      isDone = true;
      update();
      print("the response from noti is ${response.data}");
      
      // Show success popup
      Get.snackbar(
        "نجاح",
        "تم إضافة الإشعار بنجاح",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } on ServerExcption catch (e) {
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }
  }

  //====================================================
  Future<List<NotificationModel>> showNotification() async {
    try {
      var token = storage.read("access");
      print("token from noti $token");
      var response = await dio.get(EndPoint.listNotification,
          options: Options(headers: {
            ApiKeys.auth: "Beaer $token",
          }));
      print("the notification list is ${response.data}");
      List<dynamic> jsonResponse = response.data;
      List<NotificationModel> notiList =
          jsonResponse.map((e) => NotificationModel.fromJson(e)).toList();
      print("llllllllllll ${notiList.length}");

      return notiList;
    } on ServerExcption catch (e) {
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
