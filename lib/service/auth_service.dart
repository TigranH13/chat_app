import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future registerUserWithEmailandPassword(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future registerUserWithGoogle() async {
    print("googleLogin method Called");
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var user = await googleSignIn.signIn();
      if (user == null) {
        return;
      }

      final gAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      final newUser = NewUser(
          name: user.displayName!,
          email: user.email,
          avatarUrl: user.photoUrl!,
          friends: [],
          requests: []);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .set(newUser.toJson());
    } catch (error) {
      print(error);
    }
  }

  Future loginWithEmailandPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future logOut() async {
    await firebaseAuth.signOut();
  }
}
