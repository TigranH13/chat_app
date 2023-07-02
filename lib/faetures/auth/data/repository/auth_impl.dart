import 'dart:io';

import 'package:chat_application/faetures/auth/domain/repository/auth_repository.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  // final UserImage userImage;
  Reference bucketRef = FirebaseStorage.instance.ref().child('images');

  final firebaseAuth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // AuthRepositoryImpl(this.userImage);
  @override
  Future logOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future loginWithEmailandPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future registerUserWithEmailandPassword(
      NewUser user, String password, File? image) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: user.email, password: password);
    User? me = userCredential.user;
    me!.updateDisplayName(user.name);

    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference imageRef = bucketRef.child(uniqueName);
    final snapshot =
        await imageRef.putFile(image!).whenComplete(() => print('lav'));
    final imageUrl = await snapshot.ref.getDownloadURL();
    me.updatePhotoURL(imageUrl);
    await saveUser(
      NewUser(
          friends: [],
          requests: [],
          name: user.name,
          email: user.email,
          avatarUrl: imageUrl),
    );
  }

  @override
  Future registerUserWithGoogle() async {
    var user = await googleSignIn.signIn();
    if (user == null) {
      return;
    }
    final gAuth = await user.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    final us = await FirebaseAuth.instance.signInWithCredential(credential);

    if (us.additionalUserInfo!.isNewUser) {
      await saveUser(NewUser(
        friends: [],
        requests: [],
        name: user.displayName.toString(),
        email: user.email,
        avatarUrl: user.photoUrl!,
      ));

      // userImage.removeImg();
      // imageProvider.state = null;
    }
  }

  @override
  Future saveUser(
    NewUser user,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .set(user.toJson());
  }
}
