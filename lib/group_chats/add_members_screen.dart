import 'package:chat_application/group_chats/logic/group_chat_api.dart';
import 'package:chat_application/group_chats/models/group_member.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'create_group_screen.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _search = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> membersList = [];
  bool isLoading = false;

  List foundUsers = [];
  bool searching = false;

  @override
  void initState() {
    super.initState();
    GroupChatApi().getCurrentUserDetails(membersList);
  }

  void onResultTap(int index) {
    bool isAlreadyExist = false;

    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['email'] == foundUsers[index]['email']) {
        isAlreadyExist = true;
      }
    }

    if (!isAlreadyExist) {
      setState(() {
        membersList.add(GroupMember(
                avatarUrl: foundUsers[index]['avatarUrl'],
                email: foundUsers[index]['email'],
                name: foundUsers[index]['name'],
                isAdmin: false)
            .toJson());
      });
    }
  }

  Future<void> searchUser(String searchTerm) async {
    setState(() {
      searching = true;
    });
    final searchResult = [];
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

    setState(() {
      foundUsers = searchResult;

      searching = false;
    });
  }

  void onRemoveMembers(int index) {
    setState(() {
      if (index != 0) {
        membersList.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
                    onTap: () => onRemoveMembers(index),
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
                  controller: _search,
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
            isLoading
                ? Container(
                    height: size.height / 12,
                    width: size.height / 12,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () {
                      searchUser(_search.text);
                    },
                    child: const Text("Search"),
                  ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: foundUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    print('object');
                    onResultTap(index);
                  },
                  leading: Image.network(foundUsers[index]['avatarUrl']),
                  title: Text(foundUsers[index]['name']),
                  subtitle: Text(foundUsers[index]['email']),
                  trailing: const Icon(Icons.add),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: membersList.length >= 2
          ? FloatingActionButton(
              child: const Icon(Icons.forward),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CreateGroup(
                    membersList: membersList,
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
