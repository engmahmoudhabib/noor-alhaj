// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/core/api/api_consumer.dart';
import 'package:elnoor_emp/agent/core/api/end_points.dart';
import 'package:elnoor_emp/agent/core/error/exceptions.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import '../model/list_step_model.dart';
import '../model/prayer_time_model.dart';

class MainScreenController extends GetxController {
  final ApiConsumer api;
  MainScreenController({required this.api});

  final GetStorage storage = GetStorage();
  RxString fajr = ''.obs;
  RxString thohr = ''.obs;
  RxString asr = ''.obs;
  RxString maghreb = ''.obs;
  RxString ishaa = ''.obs;
  RxString sunrise = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    isLoading.value = true;
    fetchStep();
    _determinePosition().then((value) {
      fetchPrayerTime(value.latitude, value.longitude);
    });

    super.onInit();
  }

  var dio = Dio(BaseOptions(
    baseUrl: "http://85.31.237.33/test/api/",
  ));
  String? stepName;
  int? stepId;
  List<SecondaryStep> secondarSteps = [];
  RxList<StepsModel> finalStep = <StepsModel>[].obs;
  PrayerTimeModel? times;

  Future<List<StepsModel>> fetchStep() async {
    try {
      isLoading.value = true;

      // Add authentication token if required
      String token = storage.read('access') ?? '';
      dio.options.headers['Authorization'] = 'Bearer $token';
     

      var response = await dio.get(EndPoint.listSteps);
      List<dynamic> jsonResponse = response.data;
      print('steps response is : ${response.data}');
      finalStep.value =
          jsonResponse.map((e) => StepsModel.fromJson(e)).toList();

      update();
      return finalStep;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized request: ${e.response?.statusMessage}');
      } else {
        throw Exception('Failed to load steps: ${e.response?.statusMessage}');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Failed to load steps: $e');
    } finally {
      isLoading.value = false;
    }
  }

  fetchPrayerTime(lat, lng) async {
    try {
      int day = DateTime.now().day;
      int month = DateTime.now().month;
      int year = DateTime.now().year;
      int hour = DateTime.now().hour;
      int minute = DateTime.now().minute;

      var response = await api.post(EndPoint.prayerTime, data: {
        ApiKeys.longitude: lng,
        ApiKeys.latitude: lat,
        ApiKeys.day: day,
        ApiKeys.month: month,
        ApiKeys.year: year,
        "time": "${hour}:${minute}"
      });

      times = PrayerTimeModel.fromJson(response);
      fajr.value = times?.timings.fajr ?? '';
      thohr.value = times?.timings.dhuhr ?? '';
      asr.value = times?.timings.asr ?? '';
      maghreb.value = times?.timings.maghrib ?? '';
      ishaa.value = times?.timings.isha ?? '';
      sunrise.value = times?.timings.sunrise ?? '';
    } on ServerExcption catch (e) {
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> completeStep(int stepId) async {
    try {
      var response = await dio.post(
        'http://85.31.237.33/test/api/complete-step/$stepId/',
      );

      if (response.statusCode == 200) {
        final step = finalStep.firstWhere((s) => s.id == stepId);

        finalStep.refresh();
        Get.snackbar("نجاح", "تم إكمال العملية بنجاح");
        fetchStep();
      } else {
        Get.snackbar("فشل", "حدث خطأ");
      }
    } catch (e) {
      Get.snackbar("فشل", "حدث خطأ");
    }
  }
}
