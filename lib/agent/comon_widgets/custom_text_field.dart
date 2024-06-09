import 'package:elnoor_emp/theme.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController txtController;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validate;
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      this.validate, required this.txtController});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          right: media.width * 0.05, left: media.width * 0.05, bottom: 20),
      child: Container(
        height: 50,
        child: TextFormField(
          textAlign: TextAlign.right,
          controller: txtController,
          validator: validate,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
            hintTextDirection: TextDirection.rtl,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide()),
            errorBorder: OutlineInputBorder(
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



class CustomTextField3 extends StatefulWidget {
  final TextEditingController txtController;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validate;
  const CustomTextField3(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      this.validate, required this.txtController});

  @override
  State<CustomTextField3> createState() => _CustomTextField3State();
}

class _CustomTextField3State extends State<CustomTextField3> {
      int? year ;
      int? month ;
      int? day ;
      Future<void> selectDate(context)async {
        DateTime? birthday = await showDatePicker(context: context, initialDate: DateTime(DateTime.now().year) , firstDate: DateTime(1930),  lastDate: DateTime.now());
        setState(() {
          year = birthday!.year;
          month = birthday!.month;
          day = birthday!.day;
          widget.txtController.text = "${year}-${month}-${day}";
        });
      }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          right: media.width * 0.05, left: media.width * 0.05, bottom: 20),
      child: Container(
        height: 50,
        child: TextFormField(
          textAlign: TextAlign.right,
          controller: widget.txtController,
          validator: widget.validate,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            prefixIcon: IconButton(onPressed: (){selectDate(context);}, icon: Icon(Icons.calendar_today , color: TColor.primary,)),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
            hintTextDirection: TextDirection.rtl,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide()),
            errorBorder: OutlineInputBorder(
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


class CustomTextField2 extends StatelessWidget {
  final TextEditingController txtController;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validate;
  const CustomTextField2(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      this.validate, required this.txtController});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          right: media.width * 0.05, left: media.width * 0.05, bottom: 20),
      child: Container(
        height: 50,
        child: TextFormField(
          
          controller: txtController,
          validator: validate,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
            hintTextDirection: TextDirection.rtl,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide()),
            errorBorder: OutlineInputBorder(
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
