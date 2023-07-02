import 'dart:io';

import 'package:chat_application/faetures/chat/domain/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/message_model.dart';

class ChatRepostiryImpl implements ChatRepostiry {
  final curentUserName =
      FirebaseAuth.instance.currentUser!.displayName as String;
  final chatRoom = FirebaseFirestore.instance.collection('chatroom');
  @override
  Future sendFile(File file, String id) async {
    int status = 1;
    String fileName = const Uuid().v1();
    Message msg1 = Message(
        sendby: FirebaseAuth.instance.currentUser!.displayName.toString(),
        message: '',
        time: DateTime.now().toIso8601String(),
        type: 'file');
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(id)
        .collection('chats')
        .doc(fileName)
        .set(msg1.toJson());

    var ref = FirebaseStorage.instance.ref().child('files').child(fileName);
    var uploadTask = await ref.putFile(file).catchError((error) async {
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(id)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String fileUrl = await uploadTask.ref.getDownloadURL();
      print(fileUrl);

      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(id)
          .collection('chats')
          .doc(fileName)
          .update({'message': fileUrl});
    }
  }

  @override
  Future sendImage(File? image, String id) async {
    int status = 1;
    print('sas');
    String fileName = const Uuid().v1();
    Message msg = Message(
        sendby: curentUserName,
        message: '',
        time: DateTime.now().toIso8601String(),
        type: 'image');

    Message msg1 = Message(
        sendby: FirebaseAuth.instance.currentUser!.displayName.toString(),
        message: '',
        time: DateTime.now().toIso8601String(),
        type: 'image');
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(id)
        .collection('chats')
        .doc(fileName)
        .set(msg1.toJson());

    print('dddd');

    var ref =
        FirebaseStorage.instance.ref().child('images2').child('$fileName.jpg');
    var uploadTask = await ref.putFile(image!).catchError((error) async {
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(id)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      print(imageUrl);

      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(id)
          .collection('chats')
          .doc(fileName)
          .update({'message': imageUrl});
    }
  }

  @override
  Future sendMessage(String message, String id) async {
    Message msg = Message(
        sendby: curentUserName,
        message: message,
        time: DateTime.now().toIso8601String(),
        type: 'text');

    await saveMsg(msg, id);
  }

  @override
  Future saveMsg(Message msg, String id) async {
    await chatRoom.doc(id).collection('chats').add(msg.toJson());
  }
}
