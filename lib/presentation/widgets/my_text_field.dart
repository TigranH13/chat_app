// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool onbsureText;
  final bool isemail;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.isemail,
      required this.hintText,
      required this.onbsureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: onbsureText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey)),
      validator: (value) {
        if (isemail) {
          if (!EmailValidator.validate(value!) || value.isEmpty) {
            return 'email is not in correct format';
          }
        } else {
          if (value == null || value.isEmpty) {
            return 'Please enter valid text';
          }
        }
        return null;
      },
    );
  }
}
