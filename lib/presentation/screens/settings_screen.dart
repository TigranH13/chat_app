import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final id = FirebaseAuth.instance.currentUser!.uid;

  final usersCollection = FirebaseFirestore.instance.collection('users');

  NewUser? user;

  Future getUserById(String id) async {
    final documentSnapshot = await usersCollection.doc(id).get();

    final myJson = documentSnapshot.data();

    setState(() {
      user = NewUser.fromJson(myJson!);
    });
  }

  @override
  void initState() {
    getUserById(id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            user!.avatarUrl,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      user!.name,
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      user!.email,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Edit profile',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Text(
                              '>',
                              style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: () async => AuthService().logOut(),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25)),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                              Text(
                                '>',
                                style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
