import 'dart:async';
import 'dart:io';

import 'package:chat_application/models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';

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
}
