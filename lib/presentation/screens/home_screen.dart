import 'package:chat_application/presentation/screens/chats_screen.dart';
import 'package:chat_application/presentation/screens/friends_screen.dart';

import 'package:chat_application/presentation/screens/settings_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../service/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _children = [
    FrindsScreen(),
    ChatsScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: GNav(
              backgroundColor: Colors.grey,
              activeColor: Colors.white,
              color: Colors.white,
              tabBackgroundColor: Colors.grey.shade900,
              gap: 9,
              onTabChange: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              padding: const EdgeInsets.all(8),
              tabs: const [
                GButton(
                  icon: Icons.people_rounded,
                  text: 'Friends',
                ),
                GButton(
                  icon: Icons.messenger_rounded,
                  text: 'Chats',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                )
              ]),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey,
      automaticallyImplyLeading: false,
      title: const Text("Chats"),
      actions: [
        IconButton(
          icon: const Icon(Icons.exit_to_app_rounded),
          onPressed: () async {
            AuthService().logOut();
          },
        ),
      ],
    );
  }
}
