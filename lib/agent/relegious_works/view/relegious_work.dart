import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/core/api/dio_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../comon_widgets/custom_app_bar.dart';
import 'package:elnoor_emp/theme.dart';
import 'tabs/tab_1.dart';

import '../controller/religous_post_controller.dart';

class RelegiousWork extends StatelessWidget {
  RelegiousWork({super.key});

  final ReligousPostController controller =
      Get.put(ReligousPostController(api: DioConsumer(dio: Dio())));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchReliousCategories(),
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
            length: controller.categories.length,
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomAppBar(),
                    ),
                    Obx(() {
                      if (controller.categories.isEmpty) {
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
                            tabs: controller.categories.map((category) {
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
                        if (controller.categories.isEmpty) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return TabBarView(
                            children: controller.categories.map((category) {
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

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
