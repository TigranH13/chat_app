import 'dart:io';

import 'package:chat_application/faetures/auth/presantation/provider/get_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class GetImageImpl extends StateNotifier<File?> implements GetImage {
  GetImageImpl() : super(null);

  @override
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    state = File(image.path);
  }

  @override
  void delete() {
    state = null;
  }
}
