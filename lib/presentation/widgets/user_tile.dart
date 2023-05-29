import 'package:chat_application/presentation/screens/chat_room.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String userImageUrl;
  final String userName;
  final String userEmail;
  const UserTile(
      {required this.userName,
      required this.userEmail,
      super.key,
      required this.userImageUrl});

  @override
  Widget build(BuildContext context) {
    String chatRoomId(String? user1, String user2) {
      if (user1![0].toLowerCase().hashCode > user2[0].toLowerCase().hashCode) {
        return '$user1$user2';
      } else {
        return '$user2$user1';
      }
    }

    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatRoom(
              user: userName,
              chatRoomId: chatRoomId(
                  FirebaseAuth.instance.currentUser!.email, userEmail),
            ),
          ),
        );
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(userImageUrl),
      ),
      title: Text(userName),
      subtitle: Text(userEmail),
    );
  }
}
