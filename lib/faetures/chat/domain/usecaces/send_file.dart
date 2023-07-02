import 'dart:io';

abstract class SendFile {
  Future call(File file, String id);
}
