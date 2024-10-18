import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterField extends StatelessWidget {
  String label;
  TextEditingController controller;
  FocusNode focusNode;
  bool isPhoneNumber;
  bool isDouble;
  Function onSubmit;

  RegisterField(
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
          return "$label is required";
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(18.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(18.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
    );
  }
}
