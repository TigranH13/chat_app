import 'package:chat_application/presentation/screens/signUpScreen.dart';
import 'package:chat_application/presentation/widgets/emailtextformfeild.dart';
import 'package:chat_application/presentation/widgets/passwordTextFormField.dart';

import 'package:flutter/material.dart';

import '../widgets/login_bottons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: Icon(
                  Icons.message_rounded,
                  color: Colors.grey,
                  size: 150,
                )),
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 48, 48, 50),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                EmailTextFormField(emailController: emailController),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: PasswordTextFromField(
                      passwordController: passwordController),
                ),
                LoginButtons(
                    formKey: formKey,
                    emailController: emailController,
                    passwordController: passwordController),
                const LowerText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LowerText extends StatelessWidget {
  const LowerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
        width: 70,
      ),
      const Text('Have not signed yet', style: TextStyle(fontSize: 20)),
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
    ]);
  }
}
