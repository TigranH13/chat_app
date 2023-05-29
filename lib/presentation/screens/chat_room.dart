// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:chat_application/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  final String user;
  final String chatRoomId;
  ChatRoom({super.key, required this.user, required this.chatRoomId});
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void onSendMessage() async {
    Message msg = Message(
        sendby: FirebaseAuth.instance.currentUser!.displayName as String,
        message: messageController.text,
        time: 'k');
    await firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .add(msg.toJson());

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(user),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder(
                stream: firestore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> msg = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          return Container(
                              alignment: msg['sendby'] ==
                                      FirebaseAuth
                                          .instance.currentUser!.displayName
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child:
                                  Text(snapshot.data!.docs[index]['message']));
                        });
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: size.height / 10,
        width: size.width,
        alignment: Alignment.center,
        child: Container(
          height: size.height / 12,
          width: size.height / 1.1,
          child: Row(
            children: [
              Container(
                height: size.height / 12,
                width: size.width / 1.5,
                child: TextFormField(
                  controller: messageController,
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
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
              ),
              IconButton(onPressed: onSendMessage, icon: Icon(Icons.send))
            ],
          ),
        ),
      ),
    );
  }
}
