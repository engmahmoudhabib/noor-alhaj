// import 'package:dio/dio.dart';
// import 'package:fifth/core/api/end_point.dart';
// import 'package:get_storage/get_storage.dart';

// // these class responsable to keep watch on the request state and on every state
// //can do or send something
// class ApiInterceptor extends Interceptor {
//   //here everything will be proccessd with the request
//   //like [headers]
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     final storage = GetStorage();
//     final accessToken = storage.read('accessToken');
//    
//     //things will be send with the request inside the headers
//     if (accessToken != null) {
//       options.headers[ApiKeys.tokens] = {"Authorization" : "Bearer $accessToken"};
//     }
//     super.onRequest(options, handler);
//   }
// }
