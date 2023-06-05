import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/presentation/screens/chat_room.dart';
import 'package:chat_application/service/firebase_api.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class RequestUserTile extends StatelessWidget {
  final String id;

  RequestUserTile({
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
                            user: user.name,
                            chatRoomId: Utils().chatRoomId(
                                FirebaseAuth
                                    .instance.currentUser!.email.hashCode,
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
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              FirebaseApi().dissAgreeRequest(user);
                            },
                            icon: const Icon(Icons.dangerous_sharp),
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseApi().agreeRequest(user);
                            },
                            icon: const Icon(Icons.check_sharp),
                          ),
                        ],
                      ),
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
