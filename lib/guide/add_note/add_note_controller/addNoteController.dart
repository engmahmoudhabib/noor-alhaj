import 'dart:convert';

import 'package:elnoor_emp/guide/forget_password&&verfy_email/views/verfiaction_done.dart';
import 'package:elnoor_emp/guide/user_profile/model/loginModel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AddNoteController extends GetxController {
  late int id;
  late TextEditingController content;
  @override
  onInit() {
    super.onInit();
    content = TextEditingController();
  }

//token/refresh

  sendNote(int pilgrimNum) async {
    print("the pilgrimNum is ${pilgrimNum}");
    String token = GetStorage().read("access");
    print(token);
    var repsonse = await http.post(
      Uri.parse("http://alnoor-hajj.com/api/create-note/"),
      body: {"pilgrim": "${pilgrimNum}", "content": content.text},
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    print(repsonse.body);
    print(jsonDecode(utf8.decode(repsonse.bodyBytes)));
    print(repsonse.statusCode);
    if (repsonse.statusCode == 201 || repsonse.statusCode == 200) {
      Get.off(VerficationDone(
        content: 'تم اضافة البيانات بنجاح',
      ));
      content.clear();
    }
    if (repsonse.statusCode == 401) {
      print("you must refresh token maybe");
      String refresh = GetStorage().read('refresh');
      refresh =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNjI3MzU4NiwiaWF0IjoxNzE1OTI3OTg2LCJqdGkiOiI5MjllNWVhNzliYWE0ZTEyYmFhMGI3ZTU1NWVmZjMyOCIsInVzZXJfaWQiOjM0fQ.q7tdzFxeENWiTsIvZ4OIa3pphVU8hzDc7U0-HoG-UZA";
      var getToken = await http.post(
          Uri.parse("http://alnoor-hajj.com/api/token/refresh/"),
          body: {'refresh': refresh});
      print(getToken.body);
      Tokens newToken = Tokens.fromJson(jsonDecode(getToken.body));
      print("access is ${newToken.access}");
      print("refresh is ${newToken.refresh}");

      GetStorage().write("refresh", newToken.refresh);
      GetStorage().write("access", newToken.access);
      print("the id is ${id}");
      sendNote(id);
    }
  }
}
