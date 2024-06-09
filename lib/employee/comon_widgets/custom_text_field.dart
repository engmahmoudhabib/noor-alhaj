import 'package:flutter/material.dart';

import 'package:elnoor_emp/theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          right: media.width * 0.05, left: media.width * 0.05, bottom: 20),
      child: Container(
        height: 50,
        child: TextField(
          textAlign: TextAlign.end,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
            hintTextDirection: TextDirection.rtl,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide()),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: TColor.primary),
            ),
          ),
        ),
      ),
    );
  }
}
