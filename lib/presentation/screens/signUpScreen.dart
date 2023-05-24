import 'package:chat_application/presentation/screens/create_profile_screen.dart';
import 'package:chat_application/presentation/widgets/emailtextformfeild.dart';
import 'package:chat_application/presentation/widgets/passwordTextFormField.dart';
import 'package:chat_application/service/auth_service.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Center(
                  child: Icon(
                    Icons.person,
                    size: 250,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Sign Up',
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
                  height: 10,
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (() async {
                      if (formKey.currentState!.validate() == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Somthing went wrong')),
                        );
                      } else {
                        AuthService().registerUserWithEmailandPassword(
                            emailController.text, passwordController.text);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateProfileScreen(
                                email: emailController.text),
                          ),
                        );
                      }
                    }),
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(children: [
                  const SizedBox(
                    width: 70,
                  ),
                  const Text('Joined us before? ',
                      style: TextStyle(fontSize: 20)),
                  TextButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
