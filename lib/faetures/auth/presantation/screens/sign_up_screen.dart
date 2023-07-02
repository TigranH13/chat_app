// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:chat_application/faetures/auth/domain/model/user_model.dart';
import 'package:chat_application/faetures/auth/domain/usecases/module.dart';
import 'package:chat_application/faetures/auth/presantation/provider/module.dart';
import 'package:chat_application/faetures/auth/presantation/screens/login_screen.dart';
import 'package:chat_application/faetures/auth/presantation/widgets/my_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({
    super.key,
  });

  // File img;

  // Future pickImage() async {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final img = ref.watch(imageProvider);
    TextEditingController nameController = TextEditingController();

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

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
                        height: 50,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            // await pickImage();
                            ref.read(imageProvider.notifier).pickImage();
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey[800],
                            child: img == null
                                ? const Icon(Icons.add_a_photo_outlined,
                                    size: 40, color: Colors.grey)
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      img,
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
                      const Text(
                        'Lets create an account for you',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      MyTextField(
                          controller: emailController,
                          isemail: true,
                          hintText: "Email",
                          onbsureText: false),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: nameController,
                          isemail: false,
                          hintText: "UserName",
                          onbsureText: false),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: passwordController,
                          isemail: false,
                          hintText: "password",
                          onbsureText: true),
                      const SizedBox(
                        height: 25,
                      ),
                      SignUpButton(
                          ref: ref,
                          formKey: formKey,
                          img: img,
                          nameController: nameController,
                          emailController: emailController,
                          passwordController: passwordController),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already  a member?'),
                          SizedBox(
                            width: 4,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                            },
                            child: Text(
                              'Login Now',
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
        ));
  }
}

// class LowerText extends StatelessWidget {
//   const LowerText({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//       const SizedBox(
//         width: 70,
//       ),
//       const Text('Joined us before? ', style: TextStyle(fontSize: 20)),
//       TextButton(
//         onPressed: (() {
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => const LoginScreen(),
//           ));
//         }),
//         child: const Text(
//           'Login',
//           style: TextStyle(color: Colors.blue, fontSize: 20),
//         ),
//       ),
//     ]);
//   }
// }

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.formKey,
    required this.ref,
    required this.img,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });
  final WidgetRef ref;
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
            NewUser user = NewUser(
                friends: [],
                requests: [],
                name: name,
                email: email,
                avatarUrl: '');

            await registerUserWithEmailAndPassword.call(user, password, img);

            myNavigatorKey.currentState!.popUntil((route) => route.isFirst);
            ref.read(imageProvider.notifier).delete();
          }
        }),
        child: Container(
          height: 60,
          width: 400,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(9)),
          child: const Center(
            child: Text(
              'Sign up',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
