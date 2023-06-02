import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/presentation/screens/chat_room.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class RequestUserTile extends StatefulWidget {
  final String id;

  const RequestUserTile({
    super.key,
    required this.id,
  });

  @override
  State<RequestUserTile> createState() => _UserTileState();
}

class _UserTileState extends State<RequestUserTile> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  NewUser? user;
  Future getUsers() async {
    final myUser = await usersCollection.doc(widget.id).get();

    setState(() {
      user = NewUser.fromJson(myUser.data()!);
    });
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
          ? const Center(child: Text('no requests yet'))
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
                            FirebaseAuth.instance.currentUser!.email.hashCode,
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
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .update({
                            'requests': FieldValue.arrayRemove([user!.email]),
                          });
                        },
                        icon: const Icon(Icons.dangerous_sharp),
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user!.email)
                              .update({
                            'friends': FieldValue.arrayUnion(
                                [FirebaseAuth.instance.currentUser!.email]),
                          });
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .update({
                            'friends': FieldValue.arrayUnion([user!.email]),
                          });

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .update({
                            'requests': FieldValue.arrayRemove([user!.email]),
                          });
                        },
                        icon: const Icon(Icons.check_sharp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
