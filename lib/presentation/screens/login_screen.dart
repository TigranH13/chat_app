import 'package:flutter/material.dart';

import '../widgets/login_bottons.dart';
import '../widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Icon(
                      Icons.message_rounded,
                      color: Colors.grey[800],
                      size: 120,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Welcome back you\'ve been missed!',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // EmailTextFormField(emailController: emailController),
                    MyTextField(
                        isemail: true,
                        controller: emailController,
                        hintText: 'Email',
                        onbsureText: false),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10, bottom: 15),
                    //   child: PasswordTextFromField(
                    //       passwordController: passwordController),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        controller: passwordController,
                        isemail: false,
                        hintText: 'Password',
                        onbsureText: true),
                    const SizedBox(
                      height: 25,
                    ),
                    LoginButtons(
                        formKey: formKey,
                        emailController: emailController,
                        passwordController: passwordController),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Not a member?'),
                        const SizedBox(
                          width: 4,
                        ),
                        TextButton(
                          onPressed: widget.onTap,
                          child: const Text(
                            'Register Now',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
