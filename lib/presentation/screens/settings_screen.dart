// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/service/auth_service.dart';
import 'package:chat_application/service/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 100,
                child: Icon(
                  Icons.person,
                  size: 80,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'tigran',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
              Text(
                'tigranhayrapetyan17ht@gmail.com',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
              Divider(
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
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
