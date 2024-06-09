import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/guide/choose_client/controller/client_controller.dart';
import 'package:elnoor_emp/manager/comon_widgets/search_bar.dart';
import 'package:elnoor_emp/splash_acreen/views/splash_screen.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comon_widgets/client_contact.dart';
import '../../comon_widgets/custom_floating_button.dart';
import '../../comon_widgets/search_bar.dart';

class ChooseClient extends StatefulWidget {
  const ChooseClient({super.key});

  @override
  State<ChooseClient> createState() => _ChooseClientState();
}

class _ChooseClientState extends State<ChooseClient> {
  ClientController controller = Get.put(ClientController());

  @override
  void initState() {
    super.initState();
    controller.isLoading.value = true;
    controller.getPilgrims2().then((_) {
      controller.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingButton(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FadeInDown(
            delay: const Duration(milliseconds: 930),
            child: const Text("الحجاج")),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
              child: Icon(Icons.logout, color: Colors.black)),
          SizedBox(
            width: 25,
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: TColor.primary,
                ),
              );
            } else if (controller.pligrims2.isEmpty) {
              return Center(
                child: Text('لا يوجد حجاج'),
              );
            } else {
              return ListView(
                children: [
                  const SizedBox(height: 30),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 800),
                    child: CustomSearchBar(
                      controller: controller.pligrimName,
                      whenComplete: () {
                        if (controller.pligrimName.text.isEmpty) {
                          controller.getPilgrims2();
                        } else {
                         controller.searchPilgrims(controller.pligrimName.text);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.pligrims2.length,
                    itemBuilder: (context, index) {
                      return FadeInRight(
                        delay: const Duration(milliseconds: 800),
                        child: ClientContact(
                          pilgrim: controller.pligrims2[index],
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'تسجيل الخروج',
          textAlign: TextAlign.center,
        ),
        content: Text(
          'هل انت متأكد من تسجيل الخروج ؟',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('إلغاء'),
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
            child: Text('موافق'),
          ),
        ],
      );
    },
  );
}
