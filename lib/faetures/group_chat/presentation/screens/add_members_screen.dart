import 'package:chat_application/faetures/group_chat/presentation/providers/module.dart';
import 'package:chat_application/faetures/profile/presentation/providers/module.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/group_member.dart';
import 'create_group_screen.dart';

class AddMemberScreen extends ConsumerWidget {
  const AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController search = TextEditingController();
    final foundUsers = ref.watch(searchProvider);
    final membersList = ref.watch(membersListProvider);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Add Members"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: membersList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      print('hjas');
                      ref
                          .watch(membersListProvider.notifier)
                          .onRemoveMembers(index);
                      print(membersList);
                    },
                    leading: Image.network(membersList[index]['avatarUrl']),
                    title: Text(membersList[index]['name']),
                    subtitle: Text(membersList[index]['email']),
                    trailing: const Icon(Icons.close),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Container(
              height: size.height / 14,
              width: size.width,
              alignment: Alignment.center,
              child: SizedBox(
                height: size.height / 14,
                width: size.width / 1.15,
                child: TextField(
                  controller: search,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 50,
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(searchProvider.notifier)
                    .searchUser(search.text.trim());
              },
              child: const Text("Search"),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: foundUsers == null ? 0 : foundUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    ref
                        .read(membersListProvider.notifier)
                        .addMembers(index, foundUsers);
                  },
                  leading: Image.network(foundUsers![index]['avatarUrl']),
                  title: Text(foundUsers[index]['name']),
                  subtitle: Text(foundUsers[index]['email']),
                  trailing: const Icon(Icons.add),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: membersList.length > 2
          ? FloatingActionButton(
              child: const Icon(Icons.forward),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CreateGroupScreen(),
                  ),
                );
              },
            )
          : const SizedBox(),
    );
  }
}
