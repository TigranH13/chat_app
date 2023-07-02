import 'dart:io';

import 'package:chat_application/faetures/chat/data/repository/chat_repository_impl.dart';
import 'package:chat_application/faetures/chat/domain/usecaces/send_file.dart';

class SendFileImpl implements SendFile {
  @override
  Future call(File file, String id) async {
    await ChatRepostiryImpl().sendFile(file, id);
  }
}
