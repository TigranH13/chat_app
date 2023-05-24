// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PasswordTextFromField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextFromField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      autofocus: false,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 202, 201, 216),
          prefixIcon: Icon(
            Icons.lock,
            color: Color.fromARGB(255, 127, 124, 124),
          ),
          hintText: 'Password',
          border: OutlineInputBorder()),
      onSaved: (String? value) {},
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
    );
  }
}
