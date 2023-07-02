import 'dart:io';

import 'package:chat_application/faetures/auth/domain/model/user_model.dart';

abstract class RegisterUserWithEmailandPassword {
  Future call(NewUser user, String password, File? image);
}
