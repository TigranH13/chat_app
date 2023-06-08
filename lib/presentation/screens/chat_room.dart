import 'package:chat_application/service/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ChatRoom extends StatelessWidget {
  final String user;
  final String chatRoomId;
  ChatRoom({super.key, required this.user, required this.chatRoomId});

  final TextEditingController messageController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(user),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.25,
              child: StreamBuilder(
                stream: firestore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> msg = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          bool isMe = msg['sendby'] ==
                              FirebaseAuth.instance.currentUser!.displayName;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
                            child: Row(
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.6),
                                  child: ClipPath(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0, vertical: 15.0),
                                      decoration: BoxDecoration(
                                        color: isMe
                                            ? const Color(0xFFFEF9EB)
                                            : const Color.fromARGB(
                                                255, 192, 177, 176),
                                        borderRadius: isMe
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(18),
                                                bottomLeft: Radius.circular(18),
                                                topRight: Radius.circular(18),
                                              )
                                            : const BorderRadius.only(
                                                topRight: Radius.circular(18),
                                                bottomLeft: Radius.circular(18),
                                                bottomRight:
                                                    Radius.circular(18),
                                              ),
                                      ),
                                      child: Text(
                                        snapshot.data!.docs[index]['message'],
                                        style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: 80.0,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      autofocus: false,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Send a message...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => FirebaseApi()
                        .onSendMessage(messageController, chatRoomId),
                    icon: const Icon(
                      Icons.send,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
