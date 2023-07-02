// import 'dart:io';

// import 'package:chat_application/faetures/auth/data/sources/image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

import 'package:chat_application/faetures/auth/data/sources/get_image_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageProvider =
    StateNotifierProvider<GetImageImpl, File?>((ref) => GetImageImpl());
