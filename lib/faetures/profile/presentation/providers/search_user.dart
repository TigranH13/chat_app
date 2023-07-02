import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUser extends StateNotifier<List?> {
  SearchUser() : super(null);

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final currentUser = FirebaseAuth.instance.currentUser;
  Future<void> searchUser(String searchTerm) async {
    final List searchResult = [];
    QuerySnapshot querySnapshot =
        await usersCollection.where('name', isEqualTo: searchTerm).get();

    for (var document in querySnapshot.docs) {
      searchResult.add(document.data());
    }

    for (var documnet in searchResult) {
      if (documnet['email'] == currentUser!.email) {
        searchResult.remove(documnet);
        return;
      }
    }

    state = searchResult;
  }
}
