// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextFormField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 202, 201, 216),
          prefixIcon: Icon(
            Icons.person,
            color: Color.fromARGB(255, 127, 124, 124),
          ),
          hintText: 'email',
          border: OutlineInputBorder()),
      onSaved: (String? value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter user Name';
        }
        return null;
      },
    );
  }
}
