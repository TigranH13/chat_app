import 'package:chat_application/faetures/group_chat/domain/models/group_model.dart';
import 'package:chat_application/faetures/group_chat/domain/repository/group_chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../../chat/domain/models/message_model.dart';

class GroupChatRepositoryImpl implements GroupChatRepository {
  final groupCollection = FirebaseFirestore.instance.collection('groups');
  final usrCollection = FirebaseFirestore.instance.collection('users');
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Future createGroup(List membersList, String groupName) async {
    String groupId = const Uuid().v1();
    await groupCollection
        .doc(groupId)
        .set(Group(members: membersList, id: groupId).toJson());

    for (int i = 0; i < membersList.length; i++) {
      String uid = membersList[i]['email'];

      await usrCollection.doc(uid).collection('groups').doc(groupId).set({
        "name": groupName,
        "id": groupId,
      });
    }

    await groupCollection.doc(groupId).collection('chats').add(Message(
            sendby: currentUser!.displayName as String,
            message: "${currentUser!.displayName} Created This Group.",
            time: DateTime.now().toIso8601String(),
            type: 'notify')
        .toJson());
  }

  @override
  Future leaveGroup(List membersList, String id) async {
    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['email'] == currentUser!.email) {
        membersList.removeAt(i);
      }
    }
    await groupCollection.doc(id).update({
      "members": membersList,
    });

    await usrCollection
        .doc(currentUser!.email)
        .collection('groups')
        .doc(id)
        .delete();
  }

  @override
  Future removeMembers(int index, List membersList, String id) async {
    String uid = membersList[index]['email'];
    membersList.removeAt(index);

    await groupCollection.doc(id).update({
      "members": membersList,
    }).then((value) async {
      await usrCollection.doc(uid).collection('groups').doc(id).delete();
    });
    print('jinjic');
  }
}
