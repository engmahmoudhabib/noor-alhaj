import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:elnoor_emp/agent/guidnace/controller/guidnace_controller.dart';
import 'package:elnoor_emp/agent/guidnace/view/single_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../comon_widgets/relegious_list_tile.dart';
import '../../../core/api/dio_consumer.dart';
import 'package:elnoor_emp/theme.dart';

class Tab6 extends StatefulWidget {
  final String category;
  const Tab6({super.key, required this.category});

  @override
  State<Tab6> createState() => _Tab6State();
}

//النية
class _Tab6State extends State<Tab6> {
  GuidnaceController controller =
      Get.put(GuidnaceController(api: DioConsumer(dio: Dio())));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getGuidPost(widget.category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: TColor.primary,
            ));
          } else if (snapshot.hasError) {
            return Center(
                child:
                    Linkify(onOpen: _onOpen, text: 'Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data![index];
                  return FadeInRightBig(
                    delay: Duration(milliseconds: 800),
                    curve: Curves.easeIn,
                    child: RelegiousListTile(
                      onTap: () {
                        // GetStorage().write("idPost", data.id );
                        controller.fetchGuidnacePost(data.id);
                        Get.to(SinglePost(
                          appBarTitle: "النية",
                        ));
                      },
                      title: data.title,
                      subTitle: data.content,
                      image: data.cover,
                      date: data.created,
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
