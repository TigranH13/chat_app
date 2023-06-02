import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future registerUserWithEmailandPassword(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  void registerUserWithGoogle() async {
    await googleSignIn.signIn();
  }

  Future loginWithEmailandPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future logOut() async {
    await firebaseAuth.signOut();
  }
}
