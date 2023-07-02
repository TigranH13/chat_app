import 'package:chat_application/faetures/chat/presentatiton/screens/chat_room.dart';
import 'package:chat_application/faetures/profile/domain/usecases/module.dart';

import 'package:chat_application/faetures/chat/presentatiton/utils/utils.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../../auth/domain/model/user_model.dart';

class UserTile extends StatelessWidget {
  final String id;

  UserTile({
    super.key,
    required this.id,
  });

  final currentUser = FirebaseAuth.instance.currentUser;

  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: usersCollection.doc(id).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final user =
                NewUser.fromJson(snapshot.data!.data() as Map<String, dynamic>);
            return snapshot.hasData
                ? ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    tileColor: Colors.grey,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatRoom(
                            isGroupChat: false,
                            name: user.name,
                            chatRoomId: Utils().chatRoomId(
                                FirebaseAuth
                                    .instance.currentUser!.email!.hashCode,
                                user.email.hashCode),
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: user.friends.contains(currentUser!.email)
                        ? IconButton(
                            onPressed: () {
                              removeFriend.call(user);
                              print('cm');
                            },
                            icon: const Icon(Icons.person_off_rounded),
                          )
                        : IconButton(
                            onPressed: () {
                              addRequest.call(user);
                            },
                            icon: const Icon(Icons.person_add_alt_outlined),
                          ),
                  )
                : const SizedBox();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
