import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/campen_register/view/camp_register1.dart';
import 'package:elnoor_emp/agent/campen_register/view/camp_register2.dart';
import 'package:elnoor_emp/agent/campen_register/view/camp_register3.dart';
import 'package:elnoor_emp/agent/campen_register/view/camp_register4.dart';
import 'package:elnoor_emp/agent/core/api/api.dart';
import 'package:elnoor_emp/agent/core/api/api_consumer.dart';
import 'package:elnoor_emp/agent/core/api/end_points.dart';
import 'package:elnoor_emp/agent/data_received/data_received.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CampenRegisterController extends GetxController {
  CampenRegisterController({required this.api});
  late GlobalKey<ScaffoldState> key;
  late ApiConsumer api;
  late Dio dio;
  late GlobalKey<ScaffoldState> scaffoldkey;
  RxBool showProgress = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    dio = Dio();
    scaffoldkey = GlobalKey<ScaffoldState>();
    // CampRegister1 controller
    firstName = TextEditingController();
    fatherName = TextEditingController();
    grandName = TextEditingController();
    familyName = TextEditingController();
    idNumber = TextEditingController();
    date = TextEditingController();

    // CampRegister2 controller
    phoneNumber = TextEditingController();
    // CampRegister3 controller
    DateTime now = DateTime.now();
    int currentYear = now.year;
    years = List.generate(25, (index) => (currentYear - index).toString());
    goes = TextEditingController();
    refrence = TextEditingController();

    // CampRegister4 controller
    dio = Dio();
    detail = TextEditingController();
    key = GlobalKey<ScaffoldState>();
    super.onInit();
  }

  // -----------------------------------------------------------------------------
  // CampRegister controller

  PageController controller = PageController();
  bool isLastPage = false;
  List<Widget> pages = [
    CampRegister1(),
    CampRegister2(),
    CampRegister3(),
    CampRegister4(),
  ];

  void onPageChanged(int index) {
    isLastPage = (index == 4);
    update();
  }

  // -----------------------------------------------------------------------------
  // CampRegister1 controller

  late String gender, optionTrip;
  late TextEditingController firstName;
  late TextEditingController fatherName;
  late TextEditingController grandName;
  late TextEditingController familyName;
  late TextEditingController idNumber;
  late TextEditingController date;
  bool areFieldsFilled() {
    return firstName.text.isNotEmpty &&
        fatherName.text.isNotEmpty &&
        grandName.text.isNotEmpty &&
        familyName.text.isNotEmpty &&
        idNumber.text.isNotEmpty &&
        date.text.isNotEmpty;
  }

  // -----------------------------------------------------------------------------
  // CampRegister2 controller
  late String job, social, address;
  late TextEditingController phoneNumber;
  bool areGood2() {
    return phoneNumber.text.isNotEmpty && phoneNumber.text.length == 9;
  }

  // -----------------------------------------------------------------------------
  // CampRegister3 controller
  late String typeAlhajj;
  late String optionjourny;
  late String lastYear;
  late String meansJourny;
  late String numberOfAlajj;
  late List<String> years;
  late TextEditingController refrence;
  late TextEditingController goes;
  bool areGood3() {
    return goes.text.isNotEmpty;
  }

  // -----------------------------------------------------------------------------
  // CampRegister4 controller
  late TextEditingController detail;
  late String blood;
  late String Diseases;
  late String helpTaoaf;
  late String helpSaae;
  late String helpWheelChair;
  bool areGood4() {
    return detail.text.isNotEmpty;
  }

  send2() async {
    print("the refrence is ${refrence.text}");
    print("the firstName.text  is ${firstName.text}");
    print("the grandName is ${grandName.text}");
    print("the idNumber is ${idNumber.text}");
    print("the familyName is ${familyName.text}");
    print("the phoneNumber is ${phoneNumber.text}");
    print("the date is ${date.text}");
    print("the job is ${job}");
    print("the gender is ${gender}");
    print("the social is ${social}");
    print("the address is ${address}");
    print("the typeAlhajj is ${typeAlhajj}");
    print("the refrence is ${refrence}");
    print("the goes.text is ${goes.text}");
    print("the lastYear is ${lastYear}");
    print("the meansJourny is ${meansJourny}");
    print("the blood is ${blood}");
    try {
      final response = await dio.post(Api.baseUrl + Api.register, data: {
        ApiKeys.firstname: firstName.text,
        ApiKeys.fathername: fatherName.text,
        ApiKeys.grandfather: grandName.text,
        ApiKeys.lastname: familyName.text,
        ApiKeys.idnumber: idNumber.text,
        ApiKeys.phonenumber:  phoneNumber.text,
        ApiKeys.birthday: date.text,
        ApiKeys.jobposition: job,
        ApiKeys.gender: gender,
        ApiKeys.optionstrip: optionTrip,
        ApiKeys.maritalstatus: social,
        ApiKeys.address: address,
        ApiKeys.alhajj: typeAlhajj,
        ApiKeys.traditionreference: refrence.text,
        ApiKeys.counthajjas: goes.text,
        ApiKeys.lastyear: lastYear,
        ApiKeys.meansjourney: meansJourny,
        ApiKeys.bloodtype: blood,
        ApiKeys.illness: Diseases == 'نعم' ? 'True' : 'False',
        ApiKeys.tawaf: helpTaoaf == 'نعم' ? 'True' : 'False',
        ApiKeys.sai: helpSaae == 'نعم' ? 'True' : 'False',
        ApiKeys.wheelchair: helpWheelChair == 'نعم' ? 'True' : 'False',
        ApiKeys.typehelp: detail.text,
      });
      print('+catch  ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.off(const DataReceived());
      }
    } on DioException catch (e) {
      Map<String, dynamic> messaeg = e.response?.data;
      print('Server error: ${messaeg['error']}');
      print('Server error: ${messaeg.values}');
      print('Server error: ${messaeg}');
      BuildContext context = scaffoldkey.currentContext!;
      showProgress.value = false;
      _showSnackBar(
        context,
        e.response!.data.toString(),
      );
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar =
        SnackBar(content: Center(child: Linkify(onOpen: (v){},  text:  message)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  send() async {
    try {
      print("the refrence is ${refrence.text}");
      final reponse2 =
          await http.post(Uri.parse(Api.baseUrl + Api.register), body: {
        ApiKeys.firstname: firstName.text,
        ApiKeys.fathername: fatherName.text,
        ApiKeys.grandfather: grandName.text,
        ApiKeys.lastname: familyName.text,
        ApiKeys.idnumber: idNumber.text,
        ApiKeys.phonenumber: '+966' + phoneNumber.text,
        ApiKeys.birthday: date.text,
        ApiKeys.jobposition: job,
        ApiKeys.gender: gender,
        ApiKeys.optionstrip: optionTrip,
        ApiKeys.maritalstatus: social,
        ApiKeys.address: address,
        ApiKeys.alhajj: typeAlhajj,
        ApiKeys.traditionreference: refrence.text,
        ApiKeys.counthajjas: goes.text,
        ApiKeys.lastyear: lastYear,
        ApiKeys.meansjourney: meansJourny,
        ApiKeys.bloodtype: blood,
        ApiKeys.illness: Diseases == 'نعم' ? 'True' : 'False',
        ApiKeys.tawaf: helpTaoaf == 'نعم' ? 'True' : 'False',
        ApiKeys.sai: helpSaae == 'نعم' ? 'True' : 'False',
        ApiKeys.wheelchair: helpWheelChair == 'نعم' ? 'True' : 'False',
        ApiKeys.typehelp: detail.text,
      });

      print("the response2 is :");
      String response2 = utf8.decode(reponse2.bodyBytes);
      print(jsonDecode(response2));
      Get.off(const DataReceived());
    } catch (e) {
      print('+catch  ${e}');
      Get.snackbar(' خطأ ', "${e.toString()}",
          snackPosition: SnackPosition.BOTTOM);
    }
    //  print('+966' + phoneNumber.text);
    //  print(date.text );
  }
}
