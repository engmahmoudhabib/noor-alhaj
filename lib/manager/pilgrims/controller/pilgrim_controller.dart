// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:elnoor_emp/manager/core/errors/exceptions.dart';
import 'package:elnoor_emp/manager/pilgrims/model/pilgrim_model.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../../core/api/api_consumer.dart';
import '../../core/api/end_points.dart';
import '../model/guides_model.dart';
import '../model/indiviual_pilgrim._model.dart';

class PilgrimController extends GetxController {
  ApiConsumer api;
  PilgrimController({required this.api});
  RxList<GuideList> guides = <GuideList>[].obs;
  RxInt numberGuide = 0.obs;
  RxBool isLoading = false.obs;
  //=================
  var dio = Dio(
    BaseOptions(
      baseUrl: EndPoint.baseUrl,
    ),
  );
  final GetStorage storage = GetStorage();
  //===================createPilgrim============================
  final TextEditingController nameController = TextEditingController();
   final TextEditingController numberController = TextEditingController();
  final TextEditingController searchName = TextEditingController();
  final TextEditingController fatherController = TextEditingController();
  final TextEditingController grandFatherController = TextEditingController();
  final TextEditingController familyController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController flightNumController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController arriveController = TextEditingController();
  final TextEditingController leaveController = TextEditingController();
  final TextEditingController boardController = TextEditingController();
  final TextEditingController gateNumController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController hotelController = TextEditingController();
  final TextEditingController hotelAddController = TextEditingController();
  final TextEditingController roomNumController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController fromCityController = TextEditingController();
  final TextEditingController toCityController = TextEditingController();
  final TextEditingController guildController = TextEditingController();
  final TextEditingController flightDateController = TextEditingController();
//=====================updatePilgrim=======================
  Rx<XFile?> image = Rx<XFile?>(null);
  Rx<String?> imagePath = Rx<String?>(null);
  final imagePicker = ImagePicker();
  var dioInstance = dioo.Dio(
    dioo.BaseOptions(
      baseUrl: "http://85.31.237.33/test/api/",
    ),
  );
  RxList<PilgrimModel> filteredPilgrims = <PilgrimModel>[].obs;
  List<PilgrimModel> pilgrimList = [];
  Rx<IndiviualPilgrim?> onePilgrim = Rx<IndiviualPilgrim?>(null);
  @override
  onInit() {
    super.onInit();
    fetchGuide();
  }

  void searchPilgrims(String query) {
    if (query.isEmpty) {
      filteredPilgrims.value = pilgrimList;
    } else {
      filteredPilgrims.value = pilgrimList.where((pilgrim) {
        final name = '${pilgrim.firstName} ${pilgrim.fatherName} ${pilgrim.lastName}'.toLowerCase();
        final phone = pilgrim.phonenumber?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        return name.contains(searchQuery) || phone.contains(searchQuery);
      }).toList();
    }
  }

  RxList<GuideList> gList = <GuideList>[].obs;
  List<GuideList> listG = [];
  List listGG = [];
  //==========================================
  uploadImage() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imagePath.value = pickedImage.path;
      storage.write('imagePath', pickedImage.path);

      var token = storage.read("access");
      print("token from uploadImage $token");

      var formData = dioo.FormData.fromMap({
        'image': await dioo.MultipartFile.fromFile(pickedImage.path,
            filename: 'upload.jpg'),
      });

      try {
        isLoading.value = true;
        var response = await dioInstance.post(
          'update-image/',
          options: dioo.Options(
            headers: {
              ApiKeys.auth: "Bearer $token",
            },
            validateStatus: (status) {
              return status! < 500; // Only throw exceptions for 500+ errors
            },
          ),
          data: formData,
        );

        print("the response from uploadImage ${response.data}");
        // Update the imagePath with the new image URL from the response
        if (response.data != null && response.data['image_url'] != null) {
          imagePath.value = response.data['image_url'];
          storage.write('imagePath', response.data['image_url']);
        }
      } on dioo.DioError catch (e) {
        if (e.response != null) {
          print('Error response data: ${e.response!.data}');
          print('Error response headers: ${e.response!.headers}');
          print('Error response request: ${e.response!.requestOptions}');
        } else {
          print('Error sending request!');
          print(e.message);
        }
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<List<PilgrimModel>> fetchPilgrims() async {
    var token = storage.read("access");
    print("the pil token is $token");
    try {
      var response = await dio.get(
        EndPoint.listPilgrims,
        options: Options(
          headers: {
            ApiKeys.auth: "Bearer $token",
          },
        ),
      );
      print("the pilgrim response is ${response.data}");
      List<dynamic> jsonResponse = response.data;
      pilgrimList = jsonResponse.map((e) => PilgrimModel.fromJson(e)).toList();
      filteredPilgrims.value = pilgrimList; // Initialize the filtered list with all pilgrims
      return pilgrimList;
    } on ServerExcption catch (e) {
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }
  }

  //=====================================================
  Future<IndiviualPilgrim> getPilgrim(int id) async {
    try {
      isLoading.value = true;
      update();
      var token = storage.read("access");
      print("token from one pilgrim $token");
      var response = await dio.get(
        EndPoint.getPilgrim(id),
        options: Options(headers: {
          ApiKeys.auth: "Bearer $token",
        }),
      );
      print("response from one pilgrim ${response.data}");
      IndiviualPilgrim pilgrim = IndiviualPilgrim.fromJson(response.data);
      print("after parsing from onePilgrim ${pilgrim.active}");
      onePilgrim.value = pilgrim;
      return pilgrim;
    } on ServerExcption catch (e) {
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  //==================================================
  createPilgrim() async {
    try {
      var token = storage.read("access");
      print(" phonenumber is ${numController.text}");
      print(" birthday is -${dateController.text}-");
      print(" first_name is -${nameController.text}-");
      print(" father_name is ${fatherController.text}");
      print(" grand_father is ${grandFatherController.text}");
      print(" last_name is ${familyController.text}");
      print(" password is ${passController.text}");
      print(" registeration_id is ${idController.text}");
      print(" flight_company is ${companyController.text}");
      print(" arrival is ${arriveController.text}");
      print(" departure is ${leaveController.text}");
      print(" hotel_address is ${hotelAddController.text}");
      var response = await dio.post(
        "http://85.31.237.33/test/api/create-pilgrim/",
        data: {
          "phonenumber": numController.text,
          "first_name": nameController.text,
          "father_name": fatherController.text,
          "grand_father": grandFatherController.text,
          "last_name": familyController.text,
          "password": passController.text,
          "birthday": "1980-11-11",
          "guide": numberGuide.value.toString(),
          "registeration_id": idController.text,
          "boarding_time": boardController.text,
          "flight_num": flightNumController.text,
          "flight_date": flightDateController.text,
          "flight_company": companyController.text,
          "gate_num": gateNumController.text,
          "from_city": fromCityController.text,
          "to_city": toCityController.text,
          "arrival": arriveController.text,
          "departure": leaveController.text,
          "status": stateController.text,
          "hotel_address": hotelAddController.text,
          "hotel": hotelController.text,
          "room_num": roomNumController.text,
          // "company_logo": "kk"
        },
        options: Options(
          contentType: 'application/json',
          headers: {
            ApiKeys.auth: "Bearer $token",
          },
        ),
      );
      print("response from add pil ${response.data}");
    } on DioException catch (e) {
      print("the error is ${e.response?.data!.values}");
      print("the error is ${e.error}");
      throw Exception('Failed to load posts: ${e.message.toString()}');
    }
  }

  createPilgrim2() async {
    // try {
    print("hello man ");
    var response = await dio.post(
      "http://85.31.237.33/test/api/create-pilgrim/",
      data: {
        "phonenumber": "+966512347741",
        "first_name": "1",
        "father_name": "2",
        "grand_father": "3",
        "last_name": " 4",
        "password": "rabee123@@",
        "registeration_id": "12345",
        "flight_company": "test",
        "arrival": "6:00",
        "departure": "4:00",
        "hotel_address": "tartus",
      },
    );
    print("response from add pil ${response.data}");
  }

  updatePilgrim(int id) async {
    try {
      isLoading.value = true;
      update();
      var token = storage.read("access");
      print("token from updatePil $token");

      Map<String, dynamic> requestBody = {
        "phonenumber": numberController.text,  // Use the controller text
        "first_name": nameController.text,
        "last_name": familyController.text,
        "hotel_address": hotelAddController.text,
        "hotel": hotelController.text,
        "room_num": roomNumController.text,
      };

      print(requestBody);

      var response = await dio.put(
        EndPoint.updatePilgrim(id),
        options: Options(
          headers: {
            ApiKeys.auth: "Bearer $token",
          },
          validateStatus: (status) {
            return status! < 500; // Only throw exceptions for 500+ errors
          },
        ),
        data: requestBody,
      );

      update();
      showDialog(
        context: Get.context!,
        builder: ((context) {
          return AlertDialog(
            content: Container(
              height: 100,
              width: 100,
              child: Column(
                children: [
                  Icon(
                    Icons.done_all_outlined,
                    size: 60,
                    color: TColor.primary,
                  ),
                  Linkify(onOpen: _onOpen, text: "تم التحديث بنجاح"),
                ],
              ),
            ),
          );
        }),
      );
      print("the response from update pil ${response.data}");
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error response data: ${e.response!.data}');
        print('Error response headers: ${e.response!.headers}');
        print('Error response request: ${e.response!.requestOptions}');
        showDialog(
          context: Get.context!,
          builder: ((context) {
            return AlertDialog(
              content: Container(
                height: 100,
                width: 100,
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    Linkify(
                        onOpen: _onOpen,
                        text: "Failed to update pilgrim: ${e.response!.data}"),
                  ],
                ),
              ),
            );
          }),
        );
      } else {
        print('Error sending request!');
        print(e.message);
        showDialog(
          context: Get.context!,
          builder: ((context) {
            return AlertDialog(
              content: Container(
                height: 100,
                width: 100,
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    Linkify(
                        onOpen: _onOpen,
                        text: "Failed to update pilgrim: ${e.message}"),
                  ],
                ),
              ),
            );
          }),
        );
      }
    } finally {
      isLoading.value = false;
      update();
      Get.back();
    }
  }

//====================================
  Future<List<GuideList>> fetchGuide() async {
    try {
      var token = storage.read("access");
      print("token from guide $token");
      var response = await dio.get(
        EndPoint.listGuides,
        options: Options(
          headers: {
            ApiKeys.auth: "Bearer $token",
          },
        ),
      );
      print("the response from guide ${response.data}");
      List<dynamic> jsonResponse = response.data;
      List<GuideList> guideList =
          jsonResponse.map((e) => GuideList.fromJson(e)).toList();
      guides.value = guideList;
      guides.refresh;
      print("after ${guideList.length}");
      gList.value = guideList;
      listGG = guideList.map((e) => e.username).toList();
      print(" here${listGG}");

      update();
      print("after all ${gList[1].username}");

      return guideList;
    } on ServerExcption catch (e) {
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }
  }

  //================================================

  createNewOne() async {
    isLoading.value = true;
    update();
    final response = await http.post(
      Uri.parse("http://85.31.237.33/test/api/create-pilgrim/"),
      body: {
        "phonenumber": numController.text,
        "first_name": nameController.text,
        "father_name": fatherController.text,
        "grand_father": grandFatherController.text,
        "last_name": familyController.text,
        "password": passController.text,
        "birthday": dateController.text,
        "guide": numberGuide.value.toString(),
        "registeration_id": idController.text,
        "boarding_time": boardController.text,
        "flight_num": flightNumController.text,
        "flight_date": flightDateController.text,
        "flight_company": companyController.text,
        "gate_num": "403",
        "from_city": fromCityController.text,
        "to_city": toCityController.text,
        "arrival": arriveController.text,
        "departure": leaveController.text,
        "status": stateController.text,
        "hotel_address": hotelAddController.text,
        "hotel": hotelController.text,
        "room_num": roomNumController.text,
        // "company_logo": "kk"
      },
    );
    _showSimpleDialog(Get.context!);
    print("the response is ${jsonDecode(utf8.decode(response.bodyBytes))}");
    isLoading.value = false;
    update();
  }

  void _showSimpleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            Center(
              child: Linkify(
                onOpen: _onOpen,
                text: 'تم إضافة الحاج بنجاح',
                style: TextStyle(
                    color: TColor.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        print('Selected: $value');
      }
    });
  }

  Future<void> deleteNoteById(String id) async {
    isLoading.value = true;
    try {
      final response =
          await dio.delete('http://85.31.237.33/test/api/delete-note/$id/');
      if (response.statusCode == 204) {
        print("Note deleted successfully");
      } else {
        print("Failed to delete the note");
      }
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        print(e.response!.data['detail']);
      } else {
        print("An error occurred: ${e.message}");
      }
    } finally {
      isLoading.value = false;
      Get.back();
      fetchPilgrims();
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
