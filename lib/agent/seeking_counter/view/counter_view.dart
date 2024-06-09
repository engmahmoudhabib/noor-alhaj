// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:elnoor_emp/agent/seeking_counter/view/seeking_counter_view.dart';
import 'package:elnoor_emp/agent/seeking_counter/view/seeking_counter_view2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../comon_widgets/custom_app_bar.dart';
import 'package:elnoor_emp/theme.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomAppBar(),
                ),
                ZoomIn(
                  delay: Duration(milliseconds: 700),
                  curve: Curves.easeInCirc,
                  child: const TabBar(
                      labelColor: TColor.primary,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: TColor.primary,
                      // isScrollable: true,
                      tabs: [
                        Tab(
                          child: Linkify(onOpen: _onOpen, text: "عداد الطواف"),
                        ),
                        Tab(
                          child: Linkify(onOpen: _onOpen, text: "عداد السعي"),
                        ),
                      ]),
                ),
                const SizedBox(height: 20),
                const Expanded(
                  child: TabBarView(children: [
                    SeekingCounterView(),
                    SeekingCounterView2(),
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
