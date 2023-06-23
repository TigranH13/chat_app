import 'package:chat_application/group_chats/models/group_model.dart';
import 'package:chat_application/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/group_member.dart';

class GroupChatApi {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future createGroup(List membersList, TextEditingController groupName) async {
    String groupId = const Uuid().v1();

    await firestore
        .collection('groups')
        .doc(groupId)
        .set(Group(members: membersList, id: groupId).toJson());

    for (int i = 0; i < membersList.length; i++) {
      String uid = membersList[i]['email'];

      await firestore
          .collection('users')
          .doc(uid)
          .collection('groups')
          .doc(groupId)
          .set({
        "name": groupName.text,
        "id": groupId,
      });
    }

    await firestore.collection('groups').doc(groupId).collection('chats').add(
        Message(
                sendby: auth.currentUser!.displayName as String,
                message: "${auth.currentUser!.displayName} Created This Group.",
                time: DateTime.now().toIso8601String(),
                type: 'notify')
            .toJson());
  }

  Future getCurrentUserDetails(List membersList) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.email)
        .get()
        .then((map) {
      membersList.add(GroupMember(
              avatarUrl: map['avatarUrl'],
              email: map['email'],
              name: map['name'],
              isAdmin: true)
          .toJson());
    });
  }
}
