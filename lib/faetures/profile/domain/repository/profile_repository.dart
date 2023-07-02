import 'dart:io';

import 'package:chat_application/faetures/auth/domain/model/user_model.dart';

abstract class ProfileRepositroy {
  Future editProfileImage(File image);
  Future editProfileName(String name);
  Future removeFriend(NewUser user);
  Future deleteRequest(NewUser user);
  Future agreeRequest(NewUser user);
  Future addRequest(NewUser user);
}
