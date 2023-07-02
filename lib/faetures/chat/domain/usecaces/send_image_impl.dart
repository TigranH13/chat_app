import 'dart:io';

import 'package:chat_application/faetures/chat/data/repository/chat_repository_impl.dart';
import 'package:chat_application/faetures/chat/domain/usecaces/send_image.dart';

class SendImageImpl implements SendImage {
  @override
  Future call(File? image, String id) async {
    await ChatRepostiryImpl().sendImage(image, id);
  }
}
