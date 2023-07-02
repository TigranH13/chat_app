import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/user_tile.dart';

class FrindsScreen extends StatelessWidget {
  FrindsScreen({super.key});

  final id = FirebaseAuth.instance.currentUser!.email;

  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: usersCollection.doc(id).snapshots(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: !snapshot.hasData
              ? const SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!['friends'].length,
                  itemBuilder: (context, index) {
                    return UserTile(id: snapshot.data!['friends'][index]);
                  },
                ),
        );
      },
    );
  }
}
