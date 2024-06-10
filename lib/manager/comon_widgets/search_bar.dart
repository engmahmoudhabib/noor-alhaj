import 'package:flutter/material.dart';
import 'package:elnoor_emp/theme.dart';

class CustomSearchBar extends StatelessWidget {
  final VoidCallback whenComplete;
  final TextEditingController controller;

  CustomSearchBar({
    Key? key,
    required this.controller,
    required this.whenComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: TColor.black.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.right,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  hintTextDirection: TextDirection.rtl,
                  hintText: "ابحث بالاسم او رقم الجوال",
                ),
                onEditingComplete: whenComplete,
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: TColor.primary, size: 30),
              onPressed: whenComplete,
            ),
          ],
        ),
      ),
    );
  }
}
