import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainTabController extends GetxController {
  Dio dio = new Dio();

  sendActivity(String isActive) async {
    int i = GetStorage().read("id");
    print("response.data 111111111111111111111111111111111111111111111111");
    final response = await dio.post(
        "http://85.31.237.33/test/api/set-active/${i}/",
        data: {'state': isActive});
    print("response.data  111111111111111111111111111111111111111111111111");
    print(response.data);
  }
}
