import 'dart:async';
import 'dart:io';

import 'package:chat_application/models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';

class FirebaseApi {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  Future addUser({
    required File? image,
    required String name,
    required String email,
    required String password,
  }) async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference = FirebaseStorage.instance.ref();
    Reference bucketRef = storageReference.child('images');
    Reference imageRef = bucketRef.child(uniqueName);

    final snapshot =
        await imageRef.putFile(image!).whenComplete(() => print('lav'));
    final imageUrl = await snapshot.ref.getDownloadURL();

    final newUser = NewUser(
        name: name,
        email: email,
        avatarUrl: imageUrl,
        friends: [],
        requests: []);

    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    user!.updateDisplayName(name);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.email)
        .set(newUser.toJson());
  }

  void editProfileImage(File? img) async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference = FirebaseStorage.instance.ref();
    Reference bucketRef = storageReference.child('images');
    Reference imageRef = bucketRef.child(uniqueName);
    DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email);

    final snapshot = await imageRef.putFile(img!).whenComplete(() => null);

    final imageUrl = await snapshot.ref.getDownloadURL();

    userRef.update({
      'avatarUrl': imageUrl,
    });
  }

  void editProfileName(TextEditingController nameController) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'name': nameController.text.trim(),
    });
  }

  void onSendMessage(
      TextEditingController messageController, String chatRoomId) async {
    if (messageController.text.isNotEmpty) {
      Message msg = Message(
          sendby: FirebaseAuth.instance.currentUser!.displayName as String,
          message: messageController.text,
          time: DateTime.now().toIso8601String());
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(msg.toJson());

      messageController.clear();
    }
  }

  void removeFriend(NewUser user) {
    usersCollection.doc(user.email).update({
      'friends':
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.email]),
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'friends': FieldValue.arrayRemove([user.email]),
    });
  }

  void addRequest(NewUser user) {
    usersCollection.doc(user.email).update({
      'requests':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.email]),
    });
  }

  void dissAgreeRequest(NewUser user) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'requests': FieldValue.arrayRemove([user.email]),
    });
  }

  void agreeRequest(NewUser user) {
    usersCollection.doc(user.email).update({
      'friends':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.email]),
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'friends': FieldValue.arrayUnion([user.email]),
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'requests': FieldValue.arrayRemove([user.email]),
    });
  }
}
