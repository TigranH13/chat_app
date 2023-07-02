import 'dart:io';

import 'package:chat_application/faetures/auth/data/repository/auth_impl.dart';
import 'package:chat_application/faetures/auth/domain/model/user_model.dart';

import 'package:chat_application/faetures/auth/domain/usecases/register_user_with_email_and_password.dart';

class RegisterUserWithEmailandPasswordImpl
    implements RegisterUserWithEmailandPassword {
  final repository = AuthRepositoryImpl();

  @override
  Future call(NewUser user, String password, File? image) async {
    await repository.registerUserWithEmailandPassword(user, password, image);
  }
}
