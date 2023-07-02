import 'dart:io';

import '../model/user_model.dart';

abstract class AuthRepository {
  Future registerUserWithGoogle();
  Future registerUserWithEmailandPassword(
      NewUser user, String password, File? image);
  Future saveUser(NewUser user);
  Future loginWithEmailandPassword(String email, String password);
  Future logOut();
}
