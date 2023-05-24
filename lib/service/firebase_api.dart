import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat_application/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  Future addUser({
    required File? image,
    required String name,
    required String email,
  }) async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference = FirebaseStorage.instance.ref();
    Reference bucketRef = storageReference.child('images');
    Reference imageRef = bucketRef.child(uniqueName);

    final snapshot =
        await imageRef.putFile(image!).whenComplete(() => print('lav'));
    final imageUrl = await snapshot.ref.getDownloadURL();

    final newUser = NewUser(
        id: Random().nextInt(10000).toString(),
        name: name,
        email: email,
        avatarUrl: imageUrl);

    FirebaseFirestore.instance
        .collection('users')
        .doc('sadsd')
        .set(newUser.toJson());
  }
}
