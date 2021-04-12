import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmit;

  const CustomTextField({Key key, this.controller, this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(color: Colors.black),
        decoration: statusInputDecoration(),
        controller: controller,
        onSubmitted: onSubmit);
  }

  InputDecoration statusInputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    );
  }
}
