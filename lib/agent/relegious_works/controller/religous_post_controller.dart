import 'dart:convert';
import 'package:elnoor_emp/agent/core/error/exceptions.dart';
import 'package:elnoor_emp/agent/guidnace/model/guidnace_model.dart';
import 'package:elnoor_emp/agent/guidnace/model/indiviual_guidnace_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/core/api/api_consumer.dart';
import 'package:elnoor_emp/agent/core/api/end_points.dart';
import 'package:elnoor_emp/employee/log_in/model/log_in_model.dart';
import 'package:elnoor_emp/employee/log_in/model/user_state.dart';
import '../model/indivicual_religious_model.dart';
import '../model/religious_post_model.dart';
import '../model/religious_categories_model.dart';

class ReligousPostController extends GetxController {
  final ApiConsumer api;
  ReligousPostController({required this.api});
  RxList<GuidnaceModel> guidPostList = <GuidnaceModel>[].obs;
  List<IndiviualGuidnaceModel> indiviualGuidePost = [];
  Rx<IndiviualGuidnaceModel?> indiviualGuidePost2 = Rx<IndiviualGuidnaceModel?>(null);
  final GetStorage storage = GetStorage();
  Rx<IndiviualReligiousModel?> post = Rx<IndiviualReligiousModel?>(null);
  Rxn<UserState> userState = Rxn<UserState>();
  RxList<ReligiousPostModel> postList = <ReligiousPostModel>[].obs;
  List<IndiviualReligiousModel> indiviualPost = [];
  RxBool isdone = true.obs;
  RxList<ReligiousCategories> categories = <ReligiousCategories>[].obs;
  RxList<ReligiousGuidnessCategories> guidanceCategories = <ReligiousGuidnessCategories>[].obs;
    RxBool show = false.obs ;

  var dio = Dio(
    BaseOptions(
      baseUrl: "http://85.31.237.33/test/api/",
    ),
  );

  Future<List<ReligiousPostModel>> getGuidPost(String category) async { 
    try { 
      userState.value = GuidePostLoading();
      var response = await dio.get(EndPoint.guidnacePost, queryParameters: {
        "category_name": category,
      });
      List<dynamic> jsonData = response.data;
      print("looooooke over here guidnace${jsonData}");
      List<ReligiousPostModel> guidePosts =
          jsonData.map((e) => ReligiousPostModel.fromJson(e)).toList();
      var guideId;
      for (var guide in guidePosts) {
        var post = guide.id;
        guideId = post;
      }
      await storage.write("guidePostId", guideId);

      print("outside on the guide ${guideId}");
      return guidePosts;
    } on ServerExcption catch (e) {
      userState.value =
          GuidePostFailure(errMessage: e.errModel.nonFieldErrors.toString());
      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }
  }
Future<IndiviualReligiousModel> fetchGuidnacePost(int id ) async {
    show.value = true ;
    try {
    //  int storedId = await storage.read("idPost");
    //  print("stored id is $storedId");
      var response = await dio.get(
        EndPoint.getindiviualGuidnacePost(id),
      );
      print("the response before parsing is ${response.data}");
      IndiviualReligiousModel singleGuidePost =
          IndiviualReligiousModel.fromJson(response.data);
      print("the single guide is ${singleGuidePost.created}");
   /*    indiviualGuidePost = [singleGuidePost];
      indiviualGuidePost2.value = singleGuidePost   ;
      show.value = false ;
      return singleGuidePost; */
        IndiviualReligiousModel singlePost =
        IndiviualReligiousModel.fromJson(response.data);
    post.value = singlePost;
    indiviualPost = [singlePost];
    isdone.value = true;
    return singlePost;
    } on ServerExcption catch (e) {
      userState.value =
          OnePostFailure(errMessage: e.errModel.nonFieldErrors.toString());

      throw Exception(
          'Failed to load posts: ${e.errModel.nonFieldErrors.toString()}');
    }
  }
  Future<List<ReligiousPostModel>> getPost(String category) async {
    userState.value = PostLoading();

    var accessToken = storage.read("access");
    var response = await dio.get(
      EndPoint.religousPost,
      queryParameters: {
        "category_name": category,
      },
      options: Options(
        headers: {"Authorization": "Bearer $accessToken"},
      ),
    );
    if (response.statusCode == 400 || response.statusCode == 401) {
      String refresh = GetStorage().read('refreshToken');
      var getToken = await dio.post(
          "http://85.31.237.33/test/api/token/refresh/",
          data: {'refresh': refresh});
      Tokens newToken = Tokens.fromJson(jsonDecode(getToken.data));

      GetStorage().write("refreshToken", newToken.refresh);
      GetStorage().write("access", newToken.access);
      getPost(category);
    }

    List<dynamic> jsonResponse = response.data;
    List<ReligiousPostModel> posts =
        jsonResponse.map((e) => ReligiousPostModel.fromJson(e)).toList();
    var id;
    for (var post in posts) {
      var postId = post.id;
      id = postId;
    }
    await storage.write("workPostsId", id);

    return posts;
  }

  Future<IndiviualReligiousModel> fetchReligiousPost(int id) async {
    isdone.value = false;
    userState.value = OnePostLoading();
    var accessToken = storage.read("access");

    var response = await dio.get(
      EndPoint.getindiviualReligiousPost(id),
      options: Options(headers: {
        ApiKeys.auth: "Bearer $accessToken",
      }),
    );
    if (response.statusCode == 400 || response.statusCode == 401) {
      String refresh = GetStorage().read('refreshToken');
      var getToken = await dio.post(
          "http://85.31.237.33/test/api/token/refresh/",
          data: {'refresh': refresh});
      Tokens newToken = Tokens.fromJson(jsonDecode(getToken.data));

      GetStorage().write("refreshToken", newToken.refresh);
      GetStorage().write("access", newToken.access);
      fetchReligiousPost(id);
    }
    IndiviualReligiousModel singlePost =
        IndiviualReligiousModel.fromJson(response.data);
    post.value = singlePost;
    indiviualPost = [singlePost];
    isdone.value = true;
    return singlePost;
  }

  Future<List<ReligiousCategories>> fetchReliousCategories() async {
    isdone.value = false;
    userState.value = PostLoading();
    var accessToken = storage.read("access");

    var response = await dio.get(
      "http://85.31.237.33/test/api/religious-categories/",
      options: Options(headers: {
        ApiKeys.auth: "Bearer $accessToken"},
      ),
    );

    if (response.statusCode == 400 || response.statusCode == 401) {
      String refresh = GetStorage().read('refreshToken');
      var getToken = await dio.post(
          "http://85.31.237.33/test/api/token/refresh/",
          data: {'refresh': refresh});
      Tokens newToken = Tokens.fromJson(jsonDecode(getToken.data));

      GetStorage().write("refreshToken", newToken.refresh);
      GetStorage().write("access", newToken.access);
      return fetchReliousCategories();
    }

    List<dynamic> data = response.data;
    List<ReligiousCategories> categories =
        data.map((json) => ReligiousCategories.fromJson(json)).toList();

    isdone.value = true;
    this.categories.value = categories;
    return categories;
  }

  Future<List<ReligiousGuidnessCategories>> fetchReliousGuidnessCategories() async {
    isdone.value = false;
    userState.value = PostLoading();
    var accessToken = storage.read("access");

    var response = await dio.get(
      "http://85.31.237.33/test/api/guidance-categories/",
      options: Options(headers: {
        ApiKeys.auth: "Bearer $accessToken"},
      ),
    );

    if (response.statusCode == 400 || response.statusCode == 401) {
      String refresh = GetStorage().read('refreshToken');
      var getToken = await dio.post(
          "http://85.31.237.33/test/api/token/refresh/",
          data: {'refresh': refresh});
      Tokens newToken = Tokens.fromJson(jsonDecode(getToken.data));

      GetStorage().write("refreshToken", newToken.refresh);
      GetStorage().write("access", newToken.access);
      return fetchReliousGuidnessCategories();
    }

    List<dynamic> data = response.data;
    List<ReligiousGuidnessCategories> categories =
        data.map((json) => ReligiousGuidnessCategories.fromJson(json)).toList();

    isdone.value = true;
    this.guidanceCategories.value = categories;
    return categories;
  }

  @override
  void onInit() {
    fetchReliousCategories();
    fetchReliousGuidnessCategories();
    super.onInit();
  }
}
