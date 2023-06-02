import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/presentation/screens/chat_room.dart';
import 'package:chat_application/utils/utils.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  final String id;

  const UserTile({
    super.key,
    required this.id,
  });

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  NewUser? user;
  Future getUsers() async {
    final myUser = await usersCollection.doc(widget.id).get();

    setState(() {
      user = NewUser.fromJson(myUser.data()!);
    });
  }

  bool toogleFirends() {
    return user!.friends.contains(currentUser!.email);
  }

  @override
  void initState() {
    getUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: user == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder(
              future: getUsers(),
              builder: (context, snapshot) => ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.grey,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatRoom(
                        user: user!.name,
                        chatRoomId: Utils().chatRoomId(
                            FirebaseAuth.instance.currentUser!.email!.hashCode,
                            user!.email.hashCode),
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user!.avatarUrl),
                ),
                title: Text(user!.name),
                subtitle: Text(user!.email),
                trailing: toogleFirends()
                    ? IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user!.email)
                              .update({
                            'friends': FieldValue.arrayRemove(
                                [FirebaseAuth.instance.currentUser!.email]),
                          });

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .update({
                            'friends': FieldValue.arrayRemove([user!.email]),
                          });
                        },
                        icon: const Icon(Icons.person_off_rounded),
                      )
                    : IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user!.email)
                              .update({
                            'requests': FieldValue.arrayUnion(
                                [FirebaseAuth.instance.currentUser!.email]),
                          });
                        },
                        icon: const Icon(Icons.person_add_alt_outlined),
                      ),
              ),
            ),
    );
  }
}
