// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:elnoor_emp/manager/core/api/end_points.dart';
import 'package:elnoor_emp/manager/core/errors/exceptions.dart';
import 'package:elnoor_emp/manager/employees/model/indiviual_employee_model.dart';
import 'package:elnoor_emp/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/add_task_model.dart';
import '../model/employee_model.dart';

class EmployeeController extends GetxController {
  //=================
  var dio = Dio(
    BaseOptions(
      baseUrl: EndPoint.baseUrl,
    ),
  );
  final GetStorage storage = GetStorage();
  //===================
  final TextEditingController taskName = TextEditingController();
  final TextEditingController taskContent = TextEditingController();
  final TextEditingController searchName = TextEditingController();
  //                     -----
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  //                    ------
  final TextEditingController updatedEmppassController =
      TextEditingController();
  final TextEditingController updatedEmpnameController =
      TextEditingController();
  final TextEditingController updatedEmpmailController =
      TextEditingController();
  final TextEditingController updatedEmpnumController = TextEditingController();
  //                   --------

  RxList<EmployeeModel> empList = <EmployeeModel>[].obs;
  Rx<IndiviualEmployeeModel?> employee = Rx<IndiviualEmployeeModel?>(null);
  AddTaskModel? newTask;
  bool isAdded = false;
  bool taskAdd = false;
  bool isLoading = false;
  RxBool isLoadingTask = false.obs;
  List ids = [];
  //==========================================

  Future<List<EmployeeModel>> fetchEmployee() async {
    try {
      var token = storage.read("access");
      print("the employee token is $token");
      var response = await dio.get(
        EndPoint.listEmployee,
        options: Options(headers: {ApiKeys.auth: "Bearer $token"}),
      );
      print(" the emp response is ${response.data}");
      List<dynamic> jsonResponse = response.data;
      List<EmployeeModel> employeeList =
          jsonResponse.map((e) => EmployeeModel.fromJson(e)).toList();
      print("the length is ${employeeList.length}");
      List employeeId = employeeList.map((e) => e.id).toList();
      var id;
      for (var emp in employeeList) {
        var idd = emp.id;
        id = idd;
      }

      for (var i in employeeList) {
        var id = i.id;
        ids.add(id);
      }

      storage.write("mm", id);
      empList.value = employeeList;
      print("the obx is ${empList[0].email}");
      return employeeList;
    } on ServerExcption catch (e) {
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }
  }

  //====================================================================
  Future<IndiviualEmployeeModel> getEmployee(int id) async {
    var token = storage.read("access");
    print("token from indiviual is $token");

    try {
      IndiviualEmployeeModel? getEmployee;
      // var id = storage.read("mm");
      var response = await dio.get(
        EndPoint.getEmployee(id),
        options: Options(headers: {ApiKeys.auth: "Bearer $token"}),
      );

      print("the one employee is ${response.data}");

      getEmployee = IndiviualEmployeeModel.fromJson(response.data);
      print("the data is ${getEmployee.id}");
      updatedEmpnameController.text = getEmployee.username??'';
      updatedEmpnumController.text = getEmployee.phonenumber??'';
      updatedEmpmailController.text = getEmployee.email??'';

      employee.value = getEmployee;

      // }
      return getEmployee;
    } on ServerExcption catch (e) {
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }
  }

  //====================================================================
  addTask(id) async {
    isLoadingTask.value = true;
    var token = storage.read("access");
    print("the token from the task is $token");

    print("the empID are $id");
    try {
      String endPoint = EndPoint.addTask(id);
      var response = await dio.post(endPoint,
          data: {
            ApiKeys.title: taskName.text,
            ApiKeys.content: taskContent.text,
          },
          options: Options(
            headers: {
              ApiKeys.auth: "Bearer $token",
            },
          ));
      taskAdd = true;
      update();
      print("the response from the task ${response.data}");
      newTask = AddTaskModel.fromJson(response.data);
      print("something ${newTask!.content}");
    } on ServerExcption catch (e) {
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }finally {
      isLoadingTask.value = false;
    }
  }

  //========================================================
  addEmployee() async {
    try {
      isLoading = true;
      update();
      var token = storage.read("access");
      print("token from addEmp $token");
      print({
        ApiKeys.username: nameController.text,
        ApiKeys.email: mailController.text,
        ApiKeys.password: passController.text,
        ApiKeys.phonenumber: numController.text,
      });

      var response = await dio.post(
        EndPoint.addEmployee,
        options: Options(
          headers: {
            ApiKeys.auth: "Bearer $token",
          },
          validateStatus: (status) {
            return status! < 500; // Only throw exceptions for 500+ errors
          },
        ),
        data: {
          ApiKeys.username: nameController.text,
          ApiKeys.email: mailController.text,
          ApiKeys.password: passController.text, // Corrected field
          ApiKeys.phonenumber: numController.text,
        },
      );

      isAdded = true;
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
                  Linkify(onOpen: _onOpen, text: "تمت الإضافة بنجاح"),
                ],
              ),
            ),
          );
        }),
      );
      print("the newEmp response is ${response.data}");
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
                        text: "Failed to add employee: ${e.response!.data}"),
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
                        text: "Failed to add employee: ${e.message}"),
                  ],
                ),
              ),
            );
          }),
        );
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  //=========================================================
  updateEmployee(id) async {
    try {
      isLoading = true;
      update();
      var token = storage.read("access");

      print({
        ApiKeys.username: updatedEmpnameController.text,
        ApiKeys.phonenumber: updatedEmpnumController.text,
        ApiKeys.email: updatedEmpmailController.text,
        ApiKeys.password: updatedEmppassController.text,
      });
      var response = await dio.put(
        EndPoint.updateEmployee(id.toString()),
        data: {
          ApiKeys.username: updatedEmpnameController.text,
          ApiKeys.phonenumber: updatedEmpnumController.text,
          ApiKeys.email: updatedEmpmailController.text,
          ApiKeys.password: updatedEmppassController.text,
        },
        options: Options(
          headers: {
            ApiKeys.auth: "Bearer $token",
          },
          validateStatus: (status) {
            return status! < 500; // Only throw exceptions for 500+ errors
          },
        ),
      );

      update();
      showDialog(
        context: Get.context!,
        builder: (context) {
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
        },
      );
      print("response from updated is ${response.data}");
      print("token from update is $token");
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error response data: ${e.response!.data}');
        print('Error response headers: ${e.response!.headers}');
        print('Error response request: ${e.response!.requestOptions}');
        showDialog(
          context: Get.context!,
          builder: (context) {
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
                        text: "Failed to update employee: ${e.response!.data}"),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        print('Error sending request!');
        print(e.message);
        showDialog(
          context: Get.context!,
          builder: (context) {
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
                        text: "Failed to update employee: ${e.message}"),
                  ],
                ),
              ),
            );
          },
        );
      }
    } finally {
      isLoading = false;
      update();
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
