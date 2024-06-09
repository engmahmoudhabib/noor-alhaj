import 'dart:convert';


import 'package:elnoor_emp/guide/add_notification/model/notificaitonmodel.dart';
import 'package:elnoor_emp/guide/forget_password&&verfy_email/views/verfiaction_done.dart';
import 'package:elnoor_emp/guide/user_profile/model/loginModel.dart';
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
  String whatDay(int day){
    DateTime currentTime = DateTime.now();
    if(currentTime.day == day ){
      return "اليوم";
    } 
    else if (currentTime.day == day - 1 ){
      return "أمس" ;
    }
    else {
      String month =  getMonthName(currentTime.month);
      return "${currentTime.year} ${month} ${currentTime.day}";
    }
  }
 
  Future<List<NotificationModel>> getNotification ()async {
    String token = GetStorage().read("access");
    final response = await http.get(
      Uri.parse("http://85.31.237.33/test/api/list-notifications/"),
      headers: {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',},
      );
    if(response.statusCode == 201 || response.statusCode == 200){
      Iterable notifi  = jsonDecode(utf8.decode(response.bodyBytes)) ;
      notifictions = List<NotificationModel>.from(notifi.map((e) => NotificationModel.fromJson(e)));
    return notifictions ;
    } 
    if(response.statusCode == 401){
        String refresh = GetStorage().read('refresh');
       var getToken = await http.post(
        Uri.parse("http://85.31.237.33/test/api/token/refresh/"),
        body:  {
          'refresh': refresh});
      Tokens newToken = Tokens.fromJson(jsonDecode(getToken.body));
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
      
                  Get.off(VerficationDone(content: 'تم اضافة البيانات بنجاح',));
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