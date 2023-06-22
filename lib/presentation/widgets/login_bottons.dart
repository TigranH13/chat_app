// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../service/auth_service.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              if (!formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Somthing went wrong'),
                  ),
                );
              } else {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: ((context) => const Center(
                          child: CircularProgressIndicator(),
                        )));

                await AuthService().loginWithEmailandPassword(
                    emailController.text.trim(), passwordController.text);

                myNavigatorKey.currentState!.popUntil((route) => route.isFirst);
              }
            },
            child: Container(
              height: 60,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(9)),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: ((context) => const Center(
                        child: CircularProgressIndicator(),
                      )));
              await AuthService().registerUserWithGoogle();

              myNavigatorKey.currentState!.popUntil((route) => route.isFirst);
            },
            child: Container(
              height: 60,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(9)),
              child: const Center(
                  child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 23, right: 23),
                    child: Icon(
                      Icons.g_mobiledata_rounded,
                      color: Colors.blue,
                      size: 35,
                    ),
                  ),
                  Text(
                    'Login with Google',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ],
              )),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
