import 'package:chat_application/faetures/auth/data/repository/auth_impl.dart';
import 'package:chat_application/faetures/profile/presentation/providers/module.dart';

import 'package:chat_application/faetures/profile/presentation/screens/edit_screen.dart';
import 'package:chat_application/faetures/profile/presentation/screens/firend_requests_sreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/model/user_model.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(getUserProvider.notifier).getUserById();
    var user = ref.watch(getUserProvider);
    return user == null
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 15),
                    child: Avatar(user: user),
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    user.email,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditScreen(
                            user: user,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey,
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
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FrienRequestsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Friend Requests',
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
                  const Divider(
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () async => AuthRepositoryImpl().logOut(),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey,
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
          );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.user,
  });

  final NewUser user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: Colors.black,
        radius: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Image.network(
            user.avatarUrl,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ));
  }
}
