// ignore_for_file: avoid_print

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/core/error/exceptions.dart';
import 'package:elnoor_emp/employee/log_in/model/user_state.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/api/end_points.dart';
import '../model/user_info_model.dart';

class ProfileController extends GetxController {
  final GetStorage storage = GetStorage();
  Rx<XFile?> image = Rx<XFile?>(null);
  Rx<String?> imagePath = Rx<String?>(null);
  final imagePicker = ImagePicker();
  //=========================
  List<UserInfoModel> piligrmInfoList = [];
  UserInfoModel? pilgrimInfoo;
  var dioInstance = dio.Dio(
    dio.BaseOptions(
      baseUrl: "http://alnoor-hajj.com/api/",
    ),
  );
  UserState userState = UserInitial();
  var isLoading = false.obs;
  //===========================================================
  @override
  void onInit() {
    super.onInit();
    // Load the image path from storage when the controller is initialized
    fetchPilgremInfo();
  }

  uploadImage() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imagePath.value = pickedImage.path;
      storage.write('imagePath', pickedImage.path);

      var token = storage.read("access");
      print("token from uploadImage $token");

      var formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(pickedImage.path,
            filename: 'upload.jpg'),
      });

      try {
        isLoading.value = true;
        var response = await dioInstance.post(
          'update-image/',
          options: dio.Options(
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
      } on dio.DioError catch (e) {
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

  //=================================================================

  Future<UserInfoModel> fetchPilgremInfo() async {
    try {
      userState = OnInfoLoading();
      var stored = storage.read("pilgramId");
      print("the client id is $stored");

      var response = await dioInstance.get(
        EndPoint.getPilgrimInfo(stored),
      );

      print(" ================================================ $response");
      print(response.data['boarding_time']);

      UserInfoModel userInfo = UserInfoModel.fromJson(response.data);

      pilgrimInfoo = userInfo;
      print("the another is ${pilgrimInfoo!.active}");
      storage.write('imagePath', userInfo.image);
      imagePath.value = GetStorage().read('imagePath');

      return userInfo;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          print("Resource not found: ${e.response!.statusMessage}");
          userState = OnInfoFailure(errMessage: 'Resource not found');
        } else {
          print("Server error: ${e.response!.statusMessage}");
          userState = OnInfoFailure(
              errMessage: 'Server error: ${e.response!.statusMessage}');
        }
      } else {
        print("Unexpected error: ${e.message}");
        userState = OnInfoFailure(errMessage: 'Unexpected error: ${e.message}');
      }

      throw Exception('Failed to load posts: ${e.message}');
    }
  }
}
