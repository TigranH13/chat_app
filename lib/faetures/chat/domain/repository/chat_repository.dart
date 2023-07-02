import 'dart:io';

import '../models/message_model.dart';

abstract class ChatRepostiry {
  Future sendMessage(String message, String id);
  Future sendFile(File file, String id);
  Future sendImage(File? image, String id);
  Future saveMsg(Message msg, String id);
}
