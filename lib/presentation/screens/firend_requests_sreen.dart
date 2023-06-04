import 'package:chat_application/presentation/widgets/request_user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FrienRequestsScreen extends StatefulWidget {
  const FrienRequestsScreen({
    super.key,
  });

  @override
  State<FrienRequestsScreen> createState() => _FrienRequestsScreenState();
}

class _FrienRequestsScreenState extends State<FrienRequestsScreen> {
  List requests = [];

  final id = FirebaseAuth.instance.currentUser!.email;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  Future getFriendRequests() async {
    final myUser = await usersCollection.doc(id).get();
    setState(() {
      requests = myUser['requests'];
    });
  }

  @override
  void initState() {
    getFriendRequests();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 188, 183, 183),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
              stream: usersCollection.doc(id).snapshots(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!['requests'].length,
                        itemBuilder: (context, index) {
                          return RequestUserTile(
                              id: snapshot.data!['requests'][index]);
                        },
                      )
                    : Container();
              }),
        ),
      ),
    );
  }
}
