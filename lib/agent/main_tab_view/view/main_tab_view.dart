// ignore_for_file: avoid_prin
import 'package:elnoor_emp/agent/guidnace/view/guidness_view.dart';
import 'package:elnoor_emp/agent/main_tab_view/controller/main_tab_controller.dart';
import 'package:elnoor_emp/agent/relegious_works/view/relegious_work.dart';
import 'package:elnoor_emp/agent/seeking_counter/view/counter_view.dart';
import 'package:elnoor_emp/agent/support_chat/views/support_chat.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main_screen/views/main_screen.dart';
import '../../managment_chat/view/managment_chat.dart';

import 'package:get_storage/get_storage.dart';

class MainTabViewAgent extends StatefulWidget {
  const MainTabViewAgent({super.key});

  @override
  State<MainTabViewAgent> createState() => _MainTabViewAgentState();
}

class _MainTabViewAgentState extends State<MainTabViewAgent>
    with WidgetsBindingObserver {
  MainTabController controller = MainTabController();
  final GetStorage storage = GetStorage();
  int selectTab = 0;
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = const MainScreen();

  @override
  void initState() {
    controller.sendActivity("True");
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      if (state == AppLifecycleState.resumed) {
        controller.sendActivity("True");
        print("resumed");
      } else if (state == AppLifecycleState.paused) {
        controller.sendActivity("False");
        print("paused");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectTab,
        onPresses0: () {
          _showAlertDiaprint(context);
        },
        onPresses1: () {
          setState(() {
            selectTab = 0;
            currentTabView = const MainScreen();
          });
        },
        onPresses2: () {
          setState(() {
            selectTab = 1;
            currentTabView = RelegiousWork();
          });
        },
        onPresses3: () {
          setState(() {
            selectTab = 2;
            currentTabView = RelegiousGuidness();
          });
        },
        onPresses4: () {
          setState(() {
            selectTab = 3;
            currentTabView = const CounterView();
          });
        },
      ),
      body: Stack(
        children: [
          PageStorage(
            bucket: pageStorageBucket,
            child: currentTabView,
          ),
        ],
      ),
    );
  }
}

void _showAlertDiaprint(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var media = MediaQuery.of(context).size;

      return AlertDialog(
        content: Container(
          height: media.width * 0.4,
          width: media.width * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => ManagmentChat());
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(0.3))),
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.to(() => ManagmentChat());
                          },
                          icon: Image.asset("assets/img/chatIcon.png")),
                      const SizedBox(height: 5),
                      Linkify(onOpen: _onOpen, text: "تواصل مع الإدارة"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => SupportChat());
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(0.3))),
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.to(() => SupportChat());
                          },
                          icon: Image.asset("assets/img/chatIcon.png")),
                      const SizedBox(height: 5),
                      Linkify(onOpen: _onOpen, text: "تواصل مع المرشد"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function? onPresses0;
  final Function? onPresses1;
  final Function? onPresses2;
  final Function? onPresses3;
  final Function? onPresses4;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    this.onPresses0,
    this.onPresses1,
    this.onPresses2,
    this.onPresses3,
    this.onPresses4,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 80),
          painter: NavBarPainter(),
        ),
        Positioned(
          bottom: 40, // Adjusted for better visibility of the curve
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FloatingActionButton(
              onPressed: () => widget.onPresses0!(),
              backgroundColor: TColor.primary,
              child: Image.asset(
                "assets/img/0.png",
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: "assets/img/1.png",
                label: 'الرئيسية',
                index: 0,
                onPressed: widget.onPresses1!,
              ),
              _buildNavItem(
                icon: "assets/img/2.png",
                label: 'الأعمال الدينية',
                index: 1,
                onPressed: widget.onPresses2!,
              ),
              _buildNavItem(
                icon: "assets/img/3.png",
                label: 'الإرشاد الديني',
                index: 2,
                onPressed: widget.onPresses3!,
              ),
              _buildNavItem(
                icon: "assets/img/4.png",
                label: 'عداد السعي',
                index: 3,
                onPressed: widget.onPresses4!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required String icon,
    required String label,
    required int index,
    required Function onPressed,
  }) {
    bool isSelected = widget.selectedIndex == index;

    return IconButton(
      icon: Column(
        children: [
          isSelected
              ? Image.asset(
                  icon,
                  color: Colors.black,
                )
              : Image.asset(icon),
          Linkify(
            onOpen: _onOpen,
            text: label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
      onPressed: () => onPressed(),
    );
  }
}

class NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, 20) // Starting point
      ..lineTo(size.width * 0.35, 20)
      ..quadraticBezierTo(
          size.width * 0.40, 20, size.width * 0.40, 0) // Left curve
      ..arcToPoint(
        Offset(size.width * 0.60, 0),
        radius: Radius.circular(20),
        clockwise: false,
      ) // Arc for the FAB notch
      ..quadraticBezierTo(
          size.width * 0.60, 20, size.width * 0.65, 20) // Right curve
      ..lineTo(size.width, 20)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
