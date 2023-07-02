import 'package:chat_application/faetures/group_chat/domain/models/group_member.dart';
import 'package:chat_application/faetures/group_chat/domain/usecases/module.dart';
import 'package:chat_application/faetures/group_chat/presentation/providers/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../home_screen.dart';

class CreateGroupScreen extends ConsumerWidget {
  CreateGroupScreen({Key? key}) : super(key: key);

  final TextEditingController groupName = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final membersList = ref.watch(membersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Name"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 10,
          ),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: SizedBox(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: groupName,
                decoration: InputDecoration(
                  hintText: "Enter Group Name",
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
            onPressed: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: ((context) => const Center(
                        child: CircularProgressIndicator(),
                      )));

              await createGroup.call(membersList, groupName.text.trim());

              ref.read(membersListProvider.notifier).remove();

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
            },
            child: const Text("Create Group"),
          ),
        ],
      ),
    );
  }
}

//