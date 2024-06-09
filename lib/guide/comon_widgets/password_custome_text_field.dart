import 'package:elnoor_emp/guide/user_profile/userprofileController/login_controller.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';



class PasswordCustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType? keyboardType; 
  TextEditingController controller ; 

  PasswordCustomTextField(
      {super.key, 
      required this.controller,
      required this.hintText,
      required this.keyboardType,
       });

  @override
  State<PasswordCustomTextField> createState() => _PasswordCustomTextFieldState();
}

class _PasswordCustomTextFieldState extends State<PasswordCustomTextField> {
  loginController controller = Get.put(loginController());
  @override
  Widget build(BuildContext context) {
    bool secure = false ;
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          right: media.width * 0.05, left: media.width * 0.05, bottom: 20),
      child: Container(
        height: 70,
        // margin:EdgeInsets.symmetric(horizontal: 10) ,
        child: GetBuilder<loginController>(
          builder:(controller) =>  TextFormField(
                  textAlign: TextAlign.right, 
            controller: widget.controller,
            obscureText: controller.secure,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              prefixIcon: IconButton(onPressed: (){ 
                print(controller.secure);
                controller.lookPassowrd();
                print(controller.secure);
              }, icon: Icon(controller.secure == true ? Icons.visibility_off: Icons.visibility)),
              hintText: widget.hintText,
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
      ),
    );
  }
}
