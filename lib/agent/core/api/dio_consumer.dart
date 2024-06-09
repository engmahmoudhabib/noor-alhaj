import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/core/api/api_consumer.dart';
import 'package:elnoor_emp/agent/core/api/end_points.dart';
import 'package:elnoor_emp/agent/core/errors/exceptions.dart';

 

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    //all of this will be preformed with every request
    dio.options.baseUrl = EndPoint.baseUrl;
    // dio.interceptors.add(ApiInterceptor());
    // dio.interceptors.add(LogInterceptor(
    //   request: true,
    //   error: true,
    //   requestHeader: true,
    //   requestBody: true,
    //   responseBody: true,
    //   responseHeader: true,
    // )); //keep watch on the request and the response and print their info
  }
  @override
  Future delete(String path,
      {Object? data, Map<String, dynamic>? queryParameter}) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameter,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExcption(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameter}) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameter,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExcption(e);
    }
  }

  @override
  Future patch(String path,
      {Object? data, Map<String, dynamic>? queryParameter}) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameter,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExcption(e);
    }
  }

  @override
  Future post(String path,
      {Object? data, Map<String, dynamic>? queryParameter}) async {
    try {
      print("1");
      final response = await dio.post(
        path,
        data: data,
        // queryParameters: queryParameter,
      );
      print("2");
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      print("3");
      print(e);
      handleDioExcption(e);
    }
  }
}
