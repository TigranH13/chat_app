import 'package:chat_application/presentation/screens/signUpScreen.dart';
import 'package:chat_application/presentation/widgets/emailtextformfeild.dart';
import 'package:chat_application/presentation/widgets/passwordTextFormField.dart';
import 'package:chat_application/service/auth_service.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Center(
                    child: Icon(
                  Icons.message_rounded,
                  color: Colors.grey,
                  size: 150,
                )),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 48, 48, 50),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                EmailTextFormField(emailController: emailController),
                const SizedBox(
                  height: 10,
                ),
                PasswordTextFromField(passwordController: passwordController),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          await AuthService().loginWithEmailandPassword(
                              emailController.text, passwordController.text);
                        },
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15)),
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
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15)),
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
                      Row(children: [
                        const SizedBox(
                          width: 70,
                        ),
                        const Text('New to Logistics? ',
                            style: TextStyle(fontSize: 20)),
                        TextButton(
                          onPressed: (() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          }),
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
