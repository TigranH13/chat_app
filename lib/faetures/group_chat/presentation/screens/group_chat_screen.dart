import 'package:chat_application/faetures/group_chat/presentation/screens/add_members_screen.dart';
import 'package:chat_application/faetures/chat/presentatiton/screens/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupChatScreen extends StatelessWidget {
  GroupChatScreen({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final uid = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('users')
            .doc(uid)
            .collection('groups')
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const SizedBox()
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChatRoom(
                            isGroupChat: true,
                            name: snapshot.data!.docs[index]['name'],
                            chatRoomId: snapshot.data!.docs[index]['id'],
                          ),
                        ),
                      ),
                      leading: const Icon(Icons.group),
                      title: Text(snapshot.data!.docs[index]['name']),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AddMemberScreen(),
          ),
        ),
        tooltip: "Create Group",
        child: const Icon(Icons.create),
      ),
    );
  }
}
