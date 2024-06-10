import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/main_tab_view/view/main_tab_view.dart';
import 'package:elnoor_emp/employee/employee_tasks/views/employee_task.dart';
import 'package:elnoor_emp/employee/log_in/views/log_in.dart';
import 'package:elnoor_emp/guide/user_profile/model/loginModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../manager/main_tab_view/main_tab_view.dart';
import '../../choose_client/views/choose_client.dart';

class loginController extends GetxController {
  RxDouble height = 0.0.obs;
  RxDouble weidth = 0.0.obs;
  late Dio dio;
  late TextEditingController PhoneNumber;
  late TextEditingController password;
  bool secure = false;
  RxBool showProgress = false.obs;

  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    dio = Dio();
    PhoneNumber = TextEditingController();
    password = TextEditingController();

    //  dio.interceptors.add(_refreshTokenInterceptor);
    super.onInit();
  }

  _refreshTokenInterceptor() {}

  login2() async {
    showProgress.value = true;
    String phone = PhoneNumber.text;
    print({
      'username': phone,
      'password': password.text,
      'device_token': GetStorage().read('FCMToken'),
    });
    try {
      final response =
          await dio.post("http://alnoor-hajj.com/api/auth/login/", data: {
        'username': phone,
        'password': password.text,
        'device_token': GetStorage().read('FCMToken'),
      });

      LoginModel user = LoginModel.fromJson(response.data);
      GetStorage().write("id", user.userId);
      GetStorage().write("refresh", user.tokens?.refresh);
      GetStorage().write("access", user.tokens?.access);
      GetStorage().write("username", user.username);
      GetStorage().write("pilgramId", user.pilgrimId);
      GetStorage().write("ManagerChatId", user.managerChatId);
      GetStorage().write("guideChatId", user.guideChatId);
      GetStorage().write("userType", user.userType);
      GetStorage().write('tawaf', 0);
      GetStorage().write('saee', 0);
      GetStorage().write("guideImage", user.guideImage);
      GetStorage().write("guideName", user.guideName);

      showProgress.value = false;
      if (user.userType == 'حاج') {
        Get.off(const MainTabViewAgent());
      } else if (user.userType == 'مرشد') {
        Get.off(const ChooseClient());
      } else if (user.userType == 'موظف') {
        Get.off(const EmployeeTask());
      } else if (user.userType == 'اداري') {
        Get.off(const MainTabView());
      }
    } on DioException catch (e) {
      print(e.toString());

      BuildContext context = scaffoldkey.currentContext!;
      showProgress.value = false;
      _showSnackBar(
        context,
        e.response!.data['error'].toString(),
      );
    }
  }

  Future<void> refreshToken() async {
    String? refresh = GetStorage().read("refresh");

    if (refresh != null) {
      try {
        final response = await dio.post(
          "http://alnoor-hajj.com/api/token/refresh/",
          data: {'refresh': refresh},
        );

        // Assuming the response contains new access and refresh tokens
        GetStorage().write("access", response.data['access']);
        GetStorage().write("refresh", response.data['refresh']);

        // Navigate to the appropriate screen
        navigateToNextScreen();
      } on DioException catch (e) {
        // Handle the error
        print(e.response);
        /* BuildContext context = scaffoldkey.currentContext!;
      _showSnackBar(
        context,
        e.response?.data['error']?.toString() ?? 'Unknown error',
      ); */

        // Navigate to login screen if refresh token is invalid or expired
        Get.to(const LogInView());
      }
    } else {
      // No refresh token, navigate to login screen
      Get.to(const LogInView());
    }
  }

  void navigateToNextScreen() {
    String? userType = GetStorage().read("userType");
    print(userType);
    if (userType == 'حاج') {
      Get.offAll(const MainTabViewAgent());
    } else if (userType == 'مرشد') {
      Get.offAll(const ChooseClient());
    } else if (userType == 'موظف') {
      Get.offAll(const EmployeeTask());
    } else if (userType == 'اداري') {
      Get.offAll(const MainTabView());
    }
  }

  lookPassowrd() {
    secure = !secure;
    update();
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Center(child: Linkify(onOpen: _onOpen, text: message)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
