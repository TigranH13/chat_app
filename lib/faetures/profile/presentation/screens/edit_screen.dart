import 'package:chat_application/faetures/profile/domain/usecases/module.dart';
import 'package:chat_application/faetures/profile/presentation/providers/module.dart';
import 'package:chat_application/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/model/user_model.dart';

// ignore: must_be_immutable
class EditScreen extends ConsumerWidget {
  final NewUser? user;
  EditScreen({super.key, required this.user});

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final img = ref.watch(imgProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 188, 183, 183),
        title: const Text('Edit profile'),
        actions: [
          IconButton(
            onPressed: () async {
              if (img != null) {
                await editProfileImage.call(img);
                ref.read(imgProvider.notifier).delete();
              }

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: user == null
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          ref.read(imgProvider.notifier).pickImage();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(user!.avatarUrl),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: user!.name,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Name',
                      labelStyle: const TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        onPressed: () {
                          editProfileName.call(nameController.text.trim());

                          // FirebaseApi().editProfileName(nameController);
                        },
                        icon: const Icon(
                          Icons.check,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}
