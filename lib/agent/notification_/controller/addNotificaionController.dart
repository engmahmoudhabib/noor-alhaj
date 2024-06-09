import 'dart:convert';

import 'package:elnoor_emp/agent/notification_/model/notificaitonmodel.dart';
import 'package:elnoor_emp/employee/log_in/model/log_in_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http ;
class AddNotificationController extends GetxController{
  late TextEditingController title ;
  late TextEditingController content ;
  late List<NotificationModel> notifictions ;
  // List<NotificationModel> notifications = [];
  @override
  onInit(){
    super.onInit(); 
    title = TextEditingController();
    content = TextEditingController();
  }
  
  isMorninig(String value ){
   int value2 = int.parse(value);
    if(value2 >= 0 && value2 < 12)
   { return true ;}
   else {
    return false ;
   }
  }

 
  Future<List<NotificationModel>> getNotification ()async {
    String token = GetStorage().read("access");
    print("the token is ${token}");
    
    final response = await http.get(
      Uri.parse("http://85.31.237.33/test/api/list-notifications/"),
      headers: {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
    },
      );
      print("response.body");
      print(response.body);
    if(response.statusCode == 201 || response.statusCode == 200){
      Iterable notifi  = jsonDecode(utf8.decode(response.bodyBytes)) ;
      notifictions = List<NotificationModel>.from(notifi.map((e) => NotificationModel.fromJson(e)));
    print("notifictions.length  is ${notifictions.length}");
    return notifictions ;
    } 
    if(response.statusCode == 401){
        String refresh = GetStorage().read('refresh');
       var getToken = await http.post(
        Uri.parse("http://85.31.237.33/test/api/token/refresh/"),
        body:  {
          'refresh': refresh
        }
        );
      print(getToken.body);
      Tokens newToken = Tokens.fromJson(jsonDecode(getToken.body));
      print("access is ${newToken.access}");
      print("refresh is ${newToken.refresh}");
      
    GetStorage().write("refresh", newToken.refresh);
    GetStorage().write("access", newToken.access); 
    getNotification();
    }  
    return notifictions; 
  }

  sendNotification( )async {
    final response = await http.post(
      Uri.parse("http://85.31.237.33/test/api/send-notification/"),
      body: {
        "title":title.text,
        "content":content.text
      }
    );
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    title.clear();
    content.clear(); 
    if(response.statusCode == 200 || response.statusCode == 201){
      
                  // Get.off(VerficationDone(content: 'تم اضافة البيانات بنجاح',));
    }
  }


  String getMonthName(int monthNumber) {
  switch (monthNumber) {
    case 1:
      return "يناير";
    case 2:
      return "فبراير";
    case 3:
      return "مارس";
    case 4:
      return "أبريل";
    case 5:
      return "مايو";
    case 6:
      return "يونيو";
    case 7:
      return "يوليو";
    case 8:
      return "أغسطس";
    case 9:
      return "سبتمبر";
    case 10:
      return "أكتوبر";
    case 11:
      return "نوفمبر";
    case 12:
      return "ديسمبر";
    default:
      return "عدد الشهر غير صالح";
  }
}
}