import 'dart:io';

import 'package:chat_application/presentation/screens/login_screen.dart';
import 'package:chat_application/presentation/widgets/emailtextformfeild.dart';
import 'package:chat_application/presentation/widgets/password_text_form_field.dart';

import 'package:chat_application/service/firebase_api.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? img;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      img = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () async {
                            await pickImage();
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.blueGrey,
                            child: img == null
                                ? const Icon(Icons.add_a_photo_outlined,
                                    size: 40, color: Colors.grey)
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      img!,
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      EmailTextFormField(emailController: emailController),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: NameFormField(nameController: nameController),
                      ),
                      PasswordTextFromField(
                          passwordController: passwordController),
                      const SizedBox(
                        height: 50,
                      ),
                      SignUpButton(
                          formKey: formKey,
                          img: img,
                          nameController: nameController,
                          emailController: emailController,
                          passwordController: passwordController),
                      const SizedBox(
                        height: 50,
                      ),
                      const LowerText()
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class NameFormField extends StatelessWidget {
  const NameFormField({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 202, 201, 216),
          prefixIcon: Icon(
            Icons.person_2,
            color: Color.fromARGB(255, 127, 124, 124),
          ),
          hintText: 'name',
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
      const Text('Joined us before? ', style: TextStyle(fontSize: 20)),
      TextButton(
        onPressed: (() {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
        }),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
      ),
    ]);
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.formKey,
    required this.img,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final File? img;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (() async {
          if (formKey.currentState!.validate() == false || img == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Somthing went wrong')),
            );
          } else {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: ((context) => const Center(
                      child: CircularProgressIndicator(),
                    )));
            final name = nameController.text;
            final email = emailController.text;
            final password = passwordController.text;
            await FirebaseApi().addUser(
                image: img, name: name, email: email, password: password);

            myNavigatorKey.currentState!.popUntil((route) => route.isFirst);
          }
        }),
        child: Container(
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15)),
          child: const Center(
              child: Text(
            'Sign up',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          )),
        ),
      ),
    );
  }
}
