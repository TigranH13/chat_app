import 'dart:io';

abstract class SendImage {
  Future call(File? image, String id);
}
