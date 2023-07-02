import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:riverpod/riverpod.dart';

import '../../domain/models/group_member.dart';

class AddRemoveMemberList extends StateNotifier<List<Map<String, dynamic>>> {
  AddRemoveMemberList() : super([]) {
    addCurentUset();
  }

  final curenUser = FirebaseAuth.instance.currentUser;

  void addCurentUset() {
    state.add(GroupMember(
            avatarUrl: curenUser!.photoURL!,
            email: curenUser!.email!,
            name: curenUser!.displayName!,
            isAdmin: true)
        .toJson());
  }

  void addMembers(int index, foundUsers) {
    bool isAlreadyExist = false;
    for (int i = 0; i < state.length; i++) {
      if (state[i]['email'] == foundUsers[index]['email']) {
        isAlreadyExist = true;
      }
    }

    if (!isAlreadyExist) {
      state.add(GroupMember(
              avatarUrl: foundUsers[index]['avatarUrl'],
              email: foundUsers[index]['email'],
              name: foundUsers[index]['name'],
              isAdmin: false)
          .toJson());
    }
  }

  void onRemoveMembers(int index) {
    if (index != 0) {
      print('yes');
      state.removeAt(index);
    }
  }

  void remove() {
    state.clear();
    addCurentUset();
  }
}
