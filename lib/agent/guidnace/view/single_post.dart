import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/api/dio_consumer.dart';
import '../../notification_/view/notification_view.dart';
import 'package:elnoor_emp/theme.dart';
import '../controller/guidnace_controller.dart';

class SinglePost extends StatefulWidget {
  final String appBarTitle;

  const SinglePost({
    super.key,
    required this.appBarTitle,
  });

  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  GuidnaceController controller =
      Get.put(GuidnaceController(api: DioConsumer(dio: Dio())));
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Linkify(onOpen: _onOpen, text: widget.appBarTitle),
        leading: IconButton(
          onPressed: () {
            Get.to(const AddNotification());
          },
          icon: Image.asset("assets/img/white_notif_icon.png"),
          color: TColor.primary,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset("assets/img/white_arrowBack.png"),
            color: TColor.black,
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.show.value == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          height: media.width * 0.9,
                          width: media.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(controller
                                      .indiviualGuidePost2.value!.cover),
                                  fit: BoxFit.fill)),
                        )
                      ],
                    ),
                    Positioned(
                      top: 280,
                      child: Container(
                        decoration: BoxDecoration(
                            color: TColor.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        height: media.height,
                        width: media.width,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(right: media.width * 0.04),
                            child: SizedBox(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: media.width * 0.05),
                                  Linkify(
                                    onOpen: _onOpen,
                                    text: controller
                                        .indiviualGuidePost2.value!.title,
                                    style: TextStyle(
                                        color: TColor.black, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.02,
                                  ),
                                  Linkify(
                                    onOpen: _onOpen,
                                    text: controller
                                        .indiviualGuidePost2.value!.created
                                        .toString()
                                        .substring(0, 11),
                                    style: TextStyle(
                                        color: TColor.primary, fontSize: 16),
                                  ),
                                  SizedBox(height: media.width * 0.03),
                                  Linkify(
                                    onOpen: _onOpen,
                                    text: controller
                                        .indiviualGuidePost2.value!.content,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: media.width * 0.04),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
