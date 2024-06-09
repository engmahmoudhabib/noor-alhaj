import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/agent/campen_register/view/camp_register.dart';
import 'package:elnoor_emp/employee/comon_widgets/primary_button%20copy.dart';
import 'package:elnoor_emp/employee/forget_password&&verfy_email/views/forget_password.dart';
import 'package:elnoor_emp/guide/comon_widgets/number_text_field.dart';
import 'package:elnoor_emp/guide/comon_widgets/password_custome_text_field.dart';
import 'package:elnoor_emp/guide/user_profile/userprofileController/login_controller.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  loginController controller = Get.put(loginController());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    controller.height.value = media.height;
    controller.weidth.value = media.width;
    return Scaffold(
      key: controller.scaffoldkey,
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: controller.showProgress.value,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/img/bg.png",
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter),
            ),
            child: Center(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  FadeInDown(
                    delay: const Duration(milliseconds: 500),
                    child: const Image(
                      image: AssetImage("assets/img/logo.png"),
                      height: 120,
                      width: 120,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 500),
                    child: Center(
                      child: Linkify(
                        onOpen: _onOpen,
                        text: "  تسجيل الدخول",
                        style: TextStyle(
                            color: TColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: media.width * 0.055),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInRight(
                    delay: const Duration(milliseconds: 500),
                    child: Linkify(
                      onOpen: _onOpen,
                      text:
                          "ادخل رقم الجوال الخاص بك و كلمة المرور \nالمرسلة في رسالة نصية إليك ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.5),
                          fontSize: media.width * 0.04),
                    ),
                  ),
                  FadeInRight(
                    delay: Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * 0.05),
                          child: const Linkify(
                              onOpen: _onOpen, text: " رقم الجوال"),
                        ),
                        const SizedBox(height: 11),
                        NumberTextField(
                          controller: controller.PhoneNumber,
                          labelText: "  ادخل رقم جوالك",
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  FadeInLeft(
                    delay: Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * 0.05),
                          child: const Linkify(
                              onOpen: _onOpen, text: " كلمة المرور"),
                        ),
                        const SizedBox(height: 10),
                        PasswordCustomTextField(
                            controller: controller.password,
                            hintText: "ادخل  كلمة المرور",
                            keyboardType: TextInputType.text),
                      ],
                    ),
                  ),
                  FadeInLeft(
                    delay: Duration(milliseconds: 500),
                    child: Align(
                      alignment: Alignment(0.9, 0.1),
                      child: TextButton(
                          onPressed: () {
                            Get.to(const ForgetPassword());
                          },
                          child: const Linkify(
                            onOpen: _onOpen,
                            text: "هل نسيت كلمة المرور",
                            style: TextStyle(
                                color: TColor.primary,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ),
                  // const SizedBox(height: 100)
                  FadeInRight(
                    delay: Duration(milliseconds: 500),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: media.width * 0.04),
                      child: PrimaryButton(
                          onTap: () {
                            controller.login2();
                          },
                          text: "تسجيل الدخول"),
                    ),
                  ),
                  FadeInRight(
                    delay: Duration(milliseconds: 500),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: media.width * 0.04),
                      child: PrimaryButton(
                          onTap: () {
                            Get.to(CampRegister());
                          },
                          text: "التسجيل بالحملة  "),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
