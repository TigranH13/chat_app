import 'dart:io';

import 'package:chat_application/models/message_model.dart';
import 'package:chat_application/service/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';

import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';

final bucketGlobal = PageStorageBucket();

class ChatRoom extends StatefulWidget {
  final String user;
  final String chatRoomId;
  ChatRoom({super.key, required this.user, required this.chatRoomId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  double? _progress;
  final TextEditingController messageController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        final imageFile = File(xFile.path);
        FirebaseApi().uploadImage(widget.chatRoomId, imageFile);
      }
    });
  }

  Future selectFele() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    final File file = File(path);
    uploadFile(widget.chatRoomId, file);
  }

  Future uploadFile(String chatRoomId, File file) async {
    int status = 1;
    String fileName = const Uuid().v1();
    Message msg1 = Message(
        sendby: FirebaseAuth.instance.currentUser!.displayName.toString(),
        message: '',
        time: DateTime.now().toIso8601String(),
        type: 'file');
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set(msg1.toJson());

    var ref = FirebaseStorage.instance.ref().child('files').child(fileName);
    var uploadTask = await ref.putFile(file).catchError((error) async {
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });
    // var uploadTask = await ref.putFile(imageFile!);

    if (status == 1) {
      String fileUrl = await uploadTask.ref.getDownloadURL();
      print(fileUrl);

      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({'message': fileUrl});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(widget.user),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.25,
              child: StreamBuilder(
                stream: firestore
                    .collection('chatroom')
                    .doc(widget.chatRoomId)
                    .collection('chats')
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return PageStorage(
                      bucket: bucketGlobal,
                      child: ListView.builder(
                          key: PageStorageKey<String>(widget.chatRoomId),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> msg =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            bool isMe = msg['sendby'] ==
                                FirebaseAuth.instance.currentUser!.displayName;
                            return
                                // msg['type'] == 'text'
                                //     ?
                                Padding(
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
                                      child: msg['type'] == 'text'
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25.0,
                                                      vertical: 15.0),
                                              decoration: BoxDecoration(
                                                color: isMe
                                                    ? const Color(0xFFFEF9EB)
                                                    : const Color.fromARGB(
                                                        255, 192, 177, 176),
                                                borderRadius: isMe
                                                    ? const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(18),
                                                        bottomLeft:
                                                            Radius.circular(18),
                                                        topRight:
                                                            Radius.circular(18),
                                                      )
                                                    : const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(18),
                                                        bottomLeft:
                                                            Radius.circular(18),
                                                        bottomRight:
                                                            Radius.circular(18),
                                                      ),
                                              ),
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    ['message'],
                                                style: const TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ))
                                          : msg['type'] == 'file'
                                              ? _progress != null
                                                  ? Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 25.0,
                                                          vertical: 15.0),
                                                      color: Colors.white,
                                                      child:
                                                          const CircularProgressIndicator(),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () async {
                                                        final file =
                                                            await FileDownloader
                                                                .downloadFile(
                                                          onProgress: (fileName,
                                                              progress) {
                                                            setState(() {
                                                              _progress =
                                                                  progress;
                                                            });
                                                          },
                                                          url: msg['message'],
                                                          onDownloadCompleted:
                                                              (path) {
                                                            setState(() {
                                                              _progress = null;
                                                            });
                                                            print('trav');
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    25.0,
                                                                vertical: 15.0),
                                                        color: Colors.white,
                                                        alignment:
                                                            msg['message'] != ""
                                                                ? null
                                                                : Alignment
                                                                    .center,
                                                        child: msg['message'] !=
                                                                ""
                                                            ? Icon(Icons
                                                                .file_download)
                                                            : const CircularProgressIndicator(),
                                                      ),
                                                    )
                                              : Container(
                                                  height: size.height / 2.5,
                                                  width: size.width / 2,
                                                  alignment:
                                                      msg['message'] != ""
                                                          ? null
                                                          : Alignment.center,
                                                  child: msg['message'] != ""
                                                      ? Image.network(
                                                          msg['message'],
                                                          fit: BoxFit.cover,
                                                        )
                                                      : const CircularProgressIndicator(),
                                                ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
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
                      decoration: InputDecoration(
                          hintText: 'Send a message...',
                          suffixIcon: IconButton(
                              onPressed: () {
                                getImage();
                              },
                              icon: const Icon(Icons.photo))),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => selectFele(),
                        icon: const Icon(
                          Icons.file_present_rounded,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                      IconButton(
                        onPressed: () => FirebaseApi().onSendMessage(
                            messageController, widget.chatRoomId),
                        icon: const Icon(
                          Icons.send,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                    ],
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
