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
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Somthing went wrong'),
                  ),
                );
              } else {
                showDialog(
                    barrierDismissible: true,
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
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(15)),
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
            height: 50,
          ),
        ],
      ),
    );
  }
}
