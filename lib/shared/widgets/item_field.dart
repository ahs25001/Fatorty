import 'package:fatorty/shared/style/colors.dart';
import 'package:flutter/material.dart';

class ItemField extends StatelessWidget {
  String label;
  TextEditingController controller;
  FocusNode focusNode;
  bool isPhoneNumber;
  bool isDouble;
  Function onSubmit;

  ItemField(
      {this.isPhoneNumber = false,
      required this.label,
      this.isDouble = false,
      required this.onSubmit,
      required this.controller,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        onSubmit();
      },
      keyboardType: isPhoneNumber
          ? TextInputType.phone
          : isDouble
              ? TextInputType.number
              : TextInputType.name,
      focusNode: focusNode,
      validator: (value) {
        if (value!.isEmpty) {

        }
        return null;
      },
      textAlign: TextAlign.center,
      cursorColor: amberColor,
      style: TextStyle(color: amberColor,),
      controller: controller,
    );
  }
}
