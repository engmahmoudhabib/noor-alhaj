import 'dart:ui';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elnoor_emp/theme.dart';
import '../../comon_widgets/custom_app_bar.dart';
import '../../core/api/dio_consumer.dart';
import '../controller/main_screen_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  MainScreenController controller =
      Get.put(MainScreenController(api: DioConsumer(dio: Dio())));

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomAppBar(),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: media.width * 0.026),
                child: ZoomIn(
                  delay: const Duration(milliseconds: 700),
                  curve: Curves.decelerate,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: TColor.primary,
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage("assets/img/weather_rec1.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Obx(
                      () => controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, right: 50, bottom: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Linkify(
                                        onOpen: _onOpen,
                                        style: TextStyle(
                                            color: TColor.white, fontSize: 16),
                                        text: ' "أوقات الصلاة"',
                                        linkStyle:
                                            const TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildPrayerTimeColumn(
                                      "الفجر",
                                      controller.fajr.value,
                                    ),
                                    _buildPrayerTimeColumn(
                                      "الشروق",
                                      controller.sunrise.value,
                                    ),
                                    _buildPrayerTimeColumn(
                                      "الظهر",
                                      controller.thohr.value,
                                    ),
                                    _buildPrayerTimeColumn(
                                      "العصر",
                                      controller.asr.value,
                                    ),
                                    _buildPrayerTimeColumn(
                                      "المغرب",
                                      controller.maghreb.value,
                                    ),
                                    _buildPrayerTimeColumn(
                                      "العشاء",
                                      controller.ishaa.value,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FadeInRight(
                    delay: const Duration(milliseconds: 700),
                    child: const Linkify(
                      onOpen: _onOpen,
                      text: "خط السير",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.finalStep.length,
                          itemBuilder: (context, index) {
                            final step = controller.finalStep[index];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 8,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    child: StepCardWidget(
                                      step: index + 1,
                                      title: step.name,
                                      details: step.secondarySteps
                                          .map((e) => '${e.name}#${e.note}')
                                          .toList(),
                                      isCompleted: step.completed,
                                      onStepComplete: () =>
                                          showCompletionDialog(
                                              context, step.id),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => showCompletionDialog(
                                          context, step.id),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        elevation: 4,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: step.completed
                                                ? TColor.primary
                                                : Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                              color: step.completed
                                                  ? Colors.white
                                                  : TColor.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (index < controller.finalStep.length - 1)
                                      CustomPaint(
                                        size: const Size(1, 50),
                                        painter: DottedLinePainter(),
                                      ),
                                  ],
                                ),
                            
                              ],
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildPrayerTimeColumn(String prayer, String time) {
    return Column(
      children: [
        Linkify(
          onOpen: _onOpen,
          text: prayer,
          style: TextStyle(color: TColor.white),
          linkStyle: const TextStyle(color: Colors.blue),
        ),
        Linkify(
          onOpen: _onOpen,
          text: time,
          style: TextStyle(color: TColor.white),
          linkStyle: const TextStyle(color: Colors.blue),
        ),
      ],
    );
  }

  void showCompletionDialog(BuildContext context, int stepId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('إكمال الخطوة')),
          content: ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Get.find<MainScreenController>().completeStep(stepId);
            },
            child: const Text('تحديث'),
          ),
        );
      },
    );
  }
}

class StepCardWidget extends StatelessWidget {
  final int step;
  final String title;
  final List<dynamic> details;
  final bool isCompleted;
  final VoidCallback onStepComplete;

  StepCardWidget({
    required this.step,
    required this.title,
    required this.details,
    required this.isCompleted,
    required this.onStepComplete,
  });

  void showDetailDialog(BuildContext context, String detail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(detail.split('#')[0])),
          content: Text(
            detail.split('#')[1],
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('موافق'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18.0),
      child: GestureDetector(
        onTap: onStepComplete,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ExpansionTile(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: TColor.primary,
              ),
            ),
            iconColor: Colors.transparent,
            collapsedIconColor: Colors.transparent,
            children: details
                .map((detail) => ListTile(
                      title: Text(detail.split('#')[0]),
                      onTap: () => showDetailDialog(context, detail),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = TColor.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 5;
    double dashSpace = 3;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
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
