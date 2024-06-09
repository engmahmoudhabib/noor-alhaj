import 'package:dio/dio.dart';
import 'package:elnoor_emp/guide/choose_client/model/pilgrims_model.dart';
import 'package:elnoor_emp/manager/pilgrims/model/indiviual_pilgrim._model.dart';
import 'package:elnoor_emp/manager/pilgrims/model/pilgrim_model.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientController extends GetxController {
  RxList<PilgrimsModel> pligrims2 = <PilgrimsModel>[].obs;
  late TextEditingController pligrimName;
  RxBool refreshpligrims = false.obs;
  RxBool isLoading = false.obs;
  late Dio dio;

  @override
  onInit() {
    dio = Dio();
    pligrimName = TextEditingController();
    pligrimName.addListener(() {
      if (pligrimName.text == '') {
        getPilgrims2();
      } else {
        getPilgrims2(name: pligrimName.text);
      }
    });
    getPilgrims2();
    super.onInit();
  }

  RxList<PilgrimModel> filteredPilgrims = <PilgrimModel>[].obs;
  List<PilgrimModel> pilgrimList = [];
  Rx<IndiviualPilgrim?> onePilgrim = Rx<IndiviualPilgrim?>(null);
  void searchPilgrims(String query) {
    if (query.isEmpty) {
      filteredPilgrims.value = pilgrimList;
    } else {
      filteredPilgrims.value = pilgrimList.where((pilgrim) {
        final name =
            '${pilgrim.firstName} ${pilgrim.fatherName} ${pilgrim.lastName}'
                .toLowerCase();
        final phone = pilgrim.phonenumber?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        return name.contains(searchQuery) || phone.contains(searchQuery);
      }).toList();
    }
  }

  getPilgrims2({String? name}) async {
    refreshpligrims.value = true;
    final response = await dio.get(
        'http://alnoor-hajj.com/api/list-guide-pilgrims',
        queryParameters: {'query': name},
        options: Options(headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access')
        }));
    print("response.data");
    print(response.data);
    print("1");
    Iterable response2 = response.data;
    print("2");
    List<PilgrimsModel> pligrims = List<PilgrimsModel>.from(
        response2.map((model) => PilgrimsModel.fromJson(model)));
    print("3");
    pligrims2.value = pligrims;
    pligrims2.refresh;
    print("4");
    refreshpligrims.value = false;
    return pligrims;
  }

  Future<void> deleteNoteById(String id) async {
    isLoading.value = true;
    try {
      final response =
          await dio.delete('http://alnoor-hajj.com/api/delete-note/$id/');
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
      getPilgrims2();
    }
  }
}
