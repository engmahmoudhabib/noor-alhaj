import 'package:flutter/material.dart';
import 'package:elnoor_emp/theme.dart';

class CustomSearchBar extends StatelessWidget {
  final Function whenComplete;
  final TextEditingController controller;

  CustomSearchBar(
      {super.key, required this.controller, required this.whenComplete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 5),
        // margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: TColor.black.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: TextField(
            textAlign: TextAlign.right,
            controller: controller,
            onChanged: (text) => whenComplete(),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              hintTextDirection: TextDirection.rtl,
              hintText: "ابحث عن حاج بالاسم او رقم الجوال",
              prefixIcon: Icon(Icons.search, color: TColor.primary, size: 30),
            ),
          ),
        ),
      ),
    );
  }
}
