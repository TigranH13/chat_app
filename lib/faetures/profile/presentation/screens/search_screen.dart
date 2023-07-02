import 'package:chat_application/faetures/profile/presentation/providers/module.dart';
import 'package:chat_application/faetures/profile/presentation/widgets/user_tile.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class SearchScreen extends ConsumerWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();

  List searchResult = [];

  bool searching = false;

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foundUsers = ref.watch(searchPRovider);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: searchController,
              onEditingComplete: () {
                print('object');
                ref
                    .read(searchPRovider.notifier)
                    .searchUser(searchController.text.trim());
              },

              // await searchUser(searchController.text),
              autofocus: false,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 202, 201, 216),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 127, 124, 124),
                  ),
                  hintText: 'Search',
                  border: OutlineInputBorder()),
              onSaved: (String? value) {},
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: foundUsers == null ? 0 : foundUsers.length,
              itemBuilder: (context, index) {
                return UserTile(id: foundUsers![index]['email']);
              },
            ),
          ],
        ),
      ),
    );
  }
}
