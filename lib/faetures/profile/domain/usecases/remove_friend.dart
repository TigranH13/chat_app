import 'package:chat_application/faetures/auth/domain/model/user_model.dart';

abstract class RemoveFriend {
  Future call(NewUser user);
}
