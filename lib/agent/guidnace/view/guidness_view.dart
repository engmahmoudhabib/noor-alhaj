import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/comon_widgets/relegious_list_tile.dart';
import 'package:elnoor_emp/agent/core/api/dio_consumer.dart';
import 'package:elnoor_emp/agent/relegious_works/controller/religous_post_controller.dart';
import 'package:elnoor_emp/agent/relegious_works/model/religious_post_model.dart';
import 'package:elnoor_emp/agent/relegious_works/view/indivicual_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../comon_widgets/custom_app_bar.dart';
import 'package:elnoor_emp/theme.dart';

class RelegiousGuidness extends StatelessWidget {
  RelegiousGuidness({super.key});

  final ReligousPostController controller =
      Get.put(ReligousPostController(api: DioConsumer(dio: Dio())));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchReliousGuidnessCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Linkify(onOpen: _onOpen, text: 'Error loading categories'),
            ),
          );
        } else {
          return DefaultTabController(
            length: controller.guidanceCategories.length,
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomAppBar(),
                    ),
                    Obx(() {
                      if (controller.guidanceCategories.isEmpty) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ZoomIn(
                          delay: Duration(milliseconds: 700),
                          curve: Curves.easeInCirc,
                          child: TabBar(
                            labelColor: TColor.primary,
                            unselectedLabelColor: Colors.black,
                            indicatorColor: TColor.primary,
                            isScrollable: true,
                            tabs: controller.guidanceCategories.map((category) {
                              return Tab(
                                child: Linkify(
                                    onOpen: _onOpen, text: category.name ?? ''),
                              );
                            }).toList(),
                          ),
                        );
                      }
                    }),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Obx(() {
                        if (controller.guidanceCategories.isEmpty) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return TabBarView(
                            children:
                                controller.guidanceCategories.map((category) {
                              return getTabView(category.name ?? '');
                            }).toList(),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget getTabView(String categoryName) {
    return Tab1(categoryName: categoryName);
  }
}

class Tab1 extends StatefulWidget {
  final String categoryName;
  const Tab1({super.key, required this.categoryName});

  @override
  State<Tab1> createState() => _Tab1State();
}

//التحلل
class _Tab1State extends State<Tab1> {
  ReligousPostController controller =
      Get.put(ReligousPostController(api: DioConsumer(dio: Dio())));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReligiousPostModel>>(
        future: controller.getGuidPost(widget.categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: TColor.primary,
            ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data![index];
                  return ZoomIn(
                    delay: Duration(milliseconds: 700),
                    curve: Curves.easeIn,
                    child: RelegiousListTile(
                      onTap: () {
                       
                        controller.fetchGuidnacePost(snapshot.data![index].id);
                        Get.to(IndivicualPost(
                          appBarTitle: '${widget.categoryName}',
                          image: snapshot.data![index].cover,
                        ));
                      },
                      title: data.title,
                      subTitle: data.content,
                      date: data.created,
                      image: data.cover,
                    ),
                  );
                });
          }
        });
    //
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
