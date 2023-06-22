import 'package:chat_application/presentation/screens/sign_up_screen.dart';

import 'package:flutter/material.dart';

import '../../presentation/screens/login_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginScreen = true;
  void tooglePages() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginScreen
        ? LoginScreen(onTap: tooglePages)
        : SignUpScreen(onTap: tooglePages);
  }
}
