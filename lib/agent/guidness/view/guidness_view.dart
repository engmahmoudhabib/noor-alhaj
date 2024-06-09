import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/agent/guidnace/view/tabs/tab_1.dart';
import 'package:elnoor_emp/agent/guidnace/view/tabs/tab_2.dart';
import 'package:elnoor_emp/agent/guidnace/view/tabs/tab_3.dart';
import 'package:elnoor_emp/agent/guidnace/view/tabs/tab_4.dart';
import 'package:elnoor_emp/agent/guidnace/view/tabs/tab_5.dart';
import 'package:elnoor_emp/agent/guidnace/view/tabs/tab_6.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../comon_widgets/custom_app_bar.dart';
import '../../comon_widgets/relegious_list_tile.dart';
import '../../comon_widgets/tab_bar_label.dart';
import 'package:elnoor_emp/theme.dart';

class RelegiousGuidness extends StatefulWidget {
  const RelegiousGuidness({super.key});

  @override
  State<RelegiousGuidness> createState() => _RelegiousGuidnessState();
}

class _RelegiousGuidnessState extends State<RelegiousGuidness> {
  bool isTurn = true;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 5,
        length: 6,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomAppBar(),
                ),
                ZoomIn(
                  delay: Duration(milliseconds: 800),
                  curve: Curves.easeInCirc,
                  child: const TabBar(
                      labelColor: TColor.primary,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: TColor.primary,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Linkify(onOpen: _onOpen, text: "التحلل"),
                        ),
                        Tab(
                          child: Linkify(onOpen: _onOpen, text: "الاضطباع"),
                        ),
                        Tab(
                          child: Linkify(onOpen: _onOpen, text: "السعي"),
                        ),
                        Tab(
                          child: Linkify(onOpen: _onOpen, text: "الطواف"),
                        ),
                        Tab(
                          child: Linkify(onOpen: _onOpen, text: "الإحرام"),
                        ),
                        Tab(
                          child: Linkify(onOpen: _onOpen, text: "النية"),
                        ),
                      ]),
                ),
                const SizedBox(height: 20),
                const Expanded(
                  child: TabBarView(children: [
                    Tab1(category: "التحلل"),
                    Tab2(category: "الاضطباع"),
                    Tab3(category: "السعي"),
                    Tab4(category: "الطواف"),
                    Tab5(category: "الإحرام"),
                    Tab6(category: "النية"),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
