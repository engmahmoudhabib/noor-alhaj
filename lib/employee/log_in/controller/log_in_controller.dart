// ignore_for_file: avoid_print

import 'package:elnoor_emp/employee/core/api/api_consumer.dart';
import 'package:elnoor_emp/employee/core/api/end_points.dart';
import 'package:elnoor_emp/employee/core/errors/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/log_in_model.dart';
import '../model/user_state.dart';

class LogInController extends GetxController {
  ApiConsumer api;
  LogInController({required this.api});
  //============logInControllers===================
  TextEditingController numberController = TextEditingController();
  TextEditingController passController = TextEditingController();
  //====================================
  UserState userState = UserInitial();
  final GetStorage storage = GetStorage();
  LogInModel? logInUser;
  //================================================

  logIn() async {
    try {
      userState = LogInLoading();
      update();
      final response = await api.post(EndPoint.logIn, data: {
        ApiKeys.username: numberController.text,
        ApiKeys.password: passController.text,
        ApiKeys.deviceId:
            "sdsdsdsdsdsdshkjhjjhjhjhjhjhjhjkjkjkjkjkjkkkkffffffffffffffffffffffffffffffffffffffffffffffffffffeeeeeeeeeeeeeeeeeeeeeeeeeeeeekkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkdd",
      });
      print("before");
      print("the login response is $response");
      logInUser = LogInModel.fromJson(response);
      final accessToken = logInUser!.tokens.access;
      final refreshToken = logInUser!.tokens.refresh;
      final userId = logInUser!.userId;
      final image = logInUser!.image;
      final fullUser = logInUser!.fullName;

      final user_name = logInUser!.fullName;
      storage.write("access", accessToken);
      storage.write("refreshToken", refreshToken);
      storage.write("id", userId);
      storage.write("image", image);
      storage.write("fullUser", fullUser);
      storage.write("userName", user_name);
      userState = LogInSuccess();
      update();

      print("the $refreshToken");
    } on ServerExcption catch (e) {
      userState =
          LogInFailure(errMessage: e.errModel.nonFieldErrors.toString());
      update();
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }
  }
}
