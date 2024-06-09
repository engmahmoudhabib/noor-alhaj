import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 


class NumberTextField extends StatelessWidget {
  String labelText; 
  TextEditingController controller ;
  NumberTextField(
      {super.key,required this.controller ,  required this.labelText, });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          right: media.width * 0.05, left: media.width * 0.05, bottom: 20),
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: controller, 
  inputFormatters: [NineDigitsFormatter()], 
                textAlign: TextAlign.right, 
                decoration: InputDecoration(
              
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: TColor.primary),
                  ),
                  hintText: labelText,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(30)),
                  hintTextDirection: TextDirection.rtl,
                ),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}
class NineDigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length >= 20) {
      return oldValue;
    }
    return newValue;
  }
}