import 'dart:io';

import 'package:chat_application/faetures/auth/domain/model/user_model.dart';
import 'package:chat_application/faetures/profile/domain/repository/profile_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ProfileRepositroyImpl implements ProfileRepositroy {
  final bucketRef = FirebaseStorage.instance.ref().child('images');
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final curentUserEmail = FirebaseAuth.instance.currentUser!.email;
  @override
  Future agreeRequest(NewUser user) async {
    usersCollection.doc(user.email).update({
      'friends': FieldValue.arrayUnion([curentUserEmail]),
    });
    deleteRequest(user);
  }

  @override
  Future editProfileImage(File image) async {
    String uniqueName = const Uuid().v1();

    Reference imageRef = bucketRef.child(uniqueName);
    DocumentReference userRef = usersCollection.doc(curentUserEmail);
    final snapshot = await imageRef.putFile(image).whenComplete(() => null);
    final imageUrl = await snapshot.ref.getDownloadURL();
    userRef.update({
      'avatarUrl': imageUrl,
    });
  }

  @override
  Future editProfileName(String name) async {
    usersCollection.doc(curentUserEmail).update({
      'name': name,
    });
  }

  @override
  Future removeFriend(NewUser user) async {
    usersCollection.doc(user.email).update({
      'friends': FieldValue.arrayRemove([curentUserEmail]),
    });
    usersCollection.doc(curentUserEmail).update({
      'friends': FieldValue.arrayRemove([user.email]),
    });
  }

  @override
  Future addRequest(NewUser user) async {
    usersCollection.doc(user.email).update({
      'requests': FieldValue.arrayUnion([curentUserEmail]),
    });
  }

  @override
  Future deleteRequest(NewUser user) async {
    usersCollection.doc(curentUserEmail).update({
      'requests': FieldValue.arrayRemove([user.email]),
    });
  }
}
