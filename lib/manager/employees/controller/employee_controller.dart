// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:elnoor_emp/manager/core/api/end_points.dart';
import 'package:elnoor_emp/manager/core/errors/exceptions.dart';
import 'package:elnoor_emp/manager/employees/model/employee_model.dart';
import 'package:elnoor_emp/manager/employees/model/indiviual_employee_model.dart';
import 'package:elnoor_emp/manager/employees/model/add_task_model.dart';
import 'package:elnoor_emp/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeController extends GetxController {
  final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl));
  final GetStorage storage = GetStorage();

  final TextEditingController taskName = TextEditingController();
  final TextEditingController taskContent = TextEditingController();
  final TextEditingController searchName = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController updatedEmppassController = TextEditingController();
  final TextEditingController updatedEmpnameController = TextEditingController();
  final TextEditingController updatedEmpmailController = TextEditingController();
  final TextEditingController updatedEmpnumController = TextEditingController();

  final employees = <EmployeeModel>[].obs;
  final filteredEmployees = <EmployeeModel>[].obs;
  RxList<EmployeeModel> empList = <EmployeeModel>[].obs;
  Rx<IndiviualEmployeeModel?> employee = Rx<IndiviualEmployeeModel?>(null);
  AddTaskModel? newTask;
  bool isAdded = false;
  bool taskAdd = false;
  bool isLoading = false;
  RxBool isLoadingTask = false.obs;
  List ids = [];

  @override
  void onInit() {
    super.onInit();
    fetchEmployee();
    searchName.addListener(filterEmployees);
  }

  Future<void> fetchEmployee() async {
    try {
      var token = storage.read("access");
      print("the employee token is $token");
      var response = await dio.get(
        EndPoint.listEmployee,
        options: Options(headers: {ApiKeys.auth: "Bearer $token"}),
      );
      print(" the emp response is ${response.data}");
      List<dynamic> jsonResponse = response.data;
      List<EmployeeModel> employeeList = jsonResponse.map((e) => EmployeeModel.fromJson(e)).toList();
      print("the length is ${employeeList.length}");

      empList.value = employeeList;
      employees.assignAll(employeeList);
      filteredEmployees.assignAll(employeeList);

      storage.write("employee_ids", employeeList.map((e) => e.id).toList());
      print("Employee IDs: ${storage.read("employee_ids")}");
    } on ServerExcption catch (e) {
      throw Exception('Failed to load employees: ${e.errModel.nonFieldErrors}');
    }
  }

  Future<IndiviualEmployeeModel> getEmployee(int id) async {
    var token = storage.read("access");
    print("token from individual employee is $token");

    try {
      var response = await dio.get(
        EndPoint.getEmployee(id),
        options: Options(headers: {ApiKeys.auth: "Bearer $token"}),
      );

      print("the one employee is ${response.data}");
      var getEmployee = IndiviualEmployeeModel.fromJson(response.data);
      print("the data is ${getEmployee.id}");
      updatedEmpnameController.text = getEmployee.username ?? '';
      updatedEmpnumController.text = getEmployee.phonenumber ?? '';
      updatedEmpmailController.text = getEmployee.email ?? '';

      employee.value = getEmployee;

      return getEmployee;
    } on ServerExcption catch (e) {
      throw Exception('Failed to load employee: ${e.errModel.nonFieldErrors}');
    }
  }

  Future<void> addTask( id) async {
    isLoadingTask.value = true;
    var token = storage.read("access");
    print("the token from the task is $token");

    try {
      var response = await dio.post(
        EndPoint.addTask(id),
        data: {
          ApiKeys.title: taskName.text,
          ApiKeys.content: taskContent.text,
        },
        options: Options(headers: {ApiKeys.auth: "Bearer $token"}),
      );
      taskAdd = true;
      newTask = AddTaskModel.fromJson(response.data);
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
                                              Linkify(
                                                  onOpen: _onOpen,
                                                  text: "نم إرسال المهمة    "),
                                            ],
                                          ),
                                        ),
                                      );
                                    }));
    } on ServerExcption catch (e) {
      throw Exception('Failed to add task: ${e.errModel.nonFieldErrors}');
    } finally {
      isLoadingTask.value = false;
    }
  }

  Future<void> addEmployee() async {
    try {
      isLoading = true;
      var token = storage.read("access");
      print("token from addEmp $token");

      var response = await dio.post(
        EndPoint.addEmployee,
        options: Options(headers: {ApiKeys.auth: "Bearer $token"}),
        data: {
          ApiKeys.username: nameController.text,
          ApiKeys.email: mailController.text,
          ApiKeys.password: passController.text,
          ApiKeys.phonenumber: numController.text,
        },
      );

      isAdded = true;
      print("New employee response: ${response.data}");
    } on DioError catch (e) {
      print('Error adding employee: ${e.response?.data ?? e.message}');
      throw Exception('Failed to add employee: ${e.response?.data ?? e.message}');
    } finally {
      isLoading = false;
    }
  }

  Future<void> updateEmployee(int id) async {
    try {
      isLoading = true;
      var token = storage.read("access");

      var response = await dio.put(
        EndPoint.updateEmployee(id.toString()),
        data: {
          ApiKeys.username: updatedEmpnameController.text,
          ApiKeys.phonenumber: updatedEmpnumController.text,
          ApiKeys.email: updatedEmpmailController.text,
          ApiKeys.password: updatedEmppassController.text,
        },
        options: Options(headers: {ApiKeys.auth: "Bearer $token"}),
      );

      print("Updated employee response: ${response.data}");
    } on DioError catch (e) {
      print('Error updating employee: ${e.response?.data ?? e.message}');
      throw Exception('Failed to update employee: ${e.response?.data ?? e.message}');
    } finally {
      isLoading = false;
    }
  }

  void filterEmployees() {
    if (searchName.text.isEmpty) {
      filteredEmployees.assignAll(employees);
    } else {
      filteredEmployees.assignAll(
        employees.where((employee) {
          return employee.username.toLowerCase().contains(searchName.text.toLowerCase());
        }).toList(),
      );
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
