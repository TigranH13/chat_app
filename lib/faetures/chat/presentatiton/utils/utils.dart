import 'dart:io';

import 'package:chat_application/faetures/chat/domain/usecaces/module.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  String chatRoomId(int user1, int user2) {
    if (user1 > user2) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    }
  }

  Future selectFele(String id) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    final File file = File(path);
    await sendFile.call(file, id);
  }

  Future getImage(chatRoomId) async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) async {
      if (xFile != null) {
        final imageFile = File(xFile.path);
        await sendImage.call(imageFile, chatRoomId);
        // FirebaseApi().uploadImage(chatRoomId, imageFile);
      }
    });
  }
}
