import 'package:chat_application/faetures/auth/domain/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetUserById extends StateNotifier<NewUser?> {
  GetUserById() : super(null);
  final id = FirebaseAuth.instance.currentUser!.email;

  final usersCollection = FirebaseFirestore.instance.collection('users');

  Future getUserById() async {
    final documentSnapshot = await usersCollection.doc(id).get();

    final myJson = documentSnapshot.data();

    state = NewUser.fromJson(myJson!);
  }
}
