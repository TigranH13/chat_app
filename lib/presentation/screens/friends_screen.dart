import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/user_tile.dart';

class FrindsScreen extends StatefulWidget {
  const FrindsScreen({super.key});

  @override
  State<FrindsScreen> createState() => _FrindsScreenState();
}

class _FrindsScreenState extends State<FrindsScreen> {
  List friends = [];

  final id = FirebaseAuth.instance.currentUser!.email;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  Future getFriendRequests() async {
    final myUser = await usersCollection.doc(id).get();
    setState(() {
      friends = myUser['friends'];
    });
  }

  @override
  void initState() {
    getFriendRequests();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: friends.isEmpty
          ? Container()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return UserTile(id: friends[index]);
              },
            ),
    );
  }
}
