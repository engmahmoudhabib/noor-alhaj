import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../comon_widgets/custom_app_bar2.dart';
import '../../core/api/dio_consumer.dart';
import '../../notification_/view/notification_view.dart';
import 'package:elnoor_emp/theme.dart';
import '../controller/religous_post_controller.dart';

class IndivicualPost extends StatefulWidget {
  final String appBarTitle;
  final String image;
  const IndivicualPost({
    super.key,
    required this.appBarTitle,
    required this.image,
  });

  @override
  State<IndivicualPost> createState() => _IndivicualPostState();
}

class _IndivicualPostState extends State<IndivicualPost> {
  ReligousPostController controller =
      Get.put(ReligousPostController(api: DioConsumer(dio: Dio())));
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
          () => controller.isdone.value == false
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
                                  image: NetworkImage(widget.image),
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
                        height: media.height - media.height * 0.5,
                        width: media.width,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: media.width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: media.width * 0.05),
                                Linkify(
                                  onOpen: _onOpen,
                                  text: controller.post.value?.title ?? '',
                                  style: TextStyle(
                                      color: TColor.black, fontSize: 20),
                                ),
                                SizedBox(
                                  height: media.width * 0.02,
                                ),
                                Linkify(
                                  onOpen: _onOpen,
                                  text: controller.post.value?.created
                                          .toString()
                                          .substring(0, 11) ??
                                      '',
                                  style: TextStyle(
                                      color: TColor.primary, fontSize: 16),
                                ),
                                SizedBox(height: media.width * 0.03),
                                Linkify(
                                  onOpen: _onOpen,
                                  text: controller.post.value?.content ?? '',
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
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}



void _onOpen(LinkableElement link) async {
  if (link.url.startsWith('https://www.youtube.com/watch?v=')) {
    String youtubeId = link.url.split('v=')[1];
    Uri youtubeUri = Uri.parse('https://www.youtube.com/watch?v=$youtubeId');

    if (await canLaunchUrl(youtubeUri)) {
      await launchUrl(youtubeUri);
    } else {
      throw 'Could not launch $youtubeUri';
    }
  } else {
    Uri uri = Uri.parse(link.url);
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
