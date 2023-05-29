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
    if (messageController.text.isNotEmpty) {
      Message msg = Message(
          sendby: FirebaseAuth.instance.currentUser!.displayName as String,
          message: messageController.text,
          time: DateTime.now().toIso8601String());
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(msg.toJson());

      messageController.clear();
    }
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
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> msg =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                  alignment: msg['sendby'] ==
                                          FirebaseAuth
                                              .instance.currentUser!.displayName
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data!.docs[index]['message'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )),
                            );
                          }),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            autofocus: false,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 202, 201, 216),
                              hintText: 'message',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: onSendMessage,
                          icon: Icon(
                            Icons.send,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 50,
            //   width: double.infinity,
            //   child: Row(
            //     children: [
            //       Container(
            //         height: size.height / 12,
            //         width: double.infinity,
            //         child: TextFormField(
            //           controller: messageController,
            //           autofocus: false,
            //           decoration: const InputDecoration(
            //               filled: true,
            //               fillColor: Color.fromARGB(255, 202, 201, 216),
            //               prefixIcon: Icon(
            //                 Icons.search,
            //                 color: Color.fromARGB(255, 127, 124, 124),
            //               ),
            //               hintText: 'Search',
            //               border: OutlineInputBorder()),
            //           onSaved: (String? value) {},
            //           validator: (String? value) {
            //             if (value == null || value.isEmpty) {
            //               return 'Please enter password';
            //             }
            //             return null;
            //           },
            //         ),
            //       ),
            //       IconButton(onPressed: onSendMessage, icon: Icon(Icons.send))
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
