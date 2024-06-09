import 'package:elnoor_emp/employee/comon_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:animate_do/animate_do.dart';
import '../../comon_widgets/custom_floating_button.dart';
import 'package:elnoor_emp/theme.dart';
import 'tabs/finished_task.dart';
import 'tabs/in_place_task.dart';
import 'tabs/in_progress_task.dart';

class EmployeeTask extends StatefulWidget {
  const EmployeeTask({super.key});

  @override
  State<EmployeeTask> createState() => _EmployeeTaskState();
}

class _EmployeeTaskState extends State<EmployeeTask> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 2,
      length: 3,
      child: Scaffold(
        floatingActionButton: const CustomFloatingButton(),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomAppBar(title: "حياك لله أخي الكريم"),
              ),
              const SizedBox(height: 5),
              TabBar(
                  indicatorColor: TColor.primary,
                  labelColor: TColor.primary,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    FadeInDown(
                      delay: const Duration(milliseconds: 800),
                      child: const Tab(
                        text: "المهام المنتهية",
                      ),
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      child: const Tab(
                        text: "المهام القائمة",
                      ),
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 800),
                      child: const Tab(
                        text: "المهام المعلقة",
                      ),
                    ),
                  ]),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(children: [
                  FadeInRight(
                      delay: const Duration(milliseconds: 800),
                      child: const FinishedTask()),
                  FadeInLeft(
                      delay: const Duration(milliseconds: 800),
                      child: const InProgressTask()),
                  FadeInRight(
                      delay: const Duration(milliseconds: 800),
                      child: const InPlaceTask()),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
