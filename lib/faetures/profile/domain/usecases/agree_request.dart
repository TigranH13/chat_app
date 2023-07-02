import 'package:chat_application/faetures/auth/domain/model/user_model.dart';

abstract class AgreeRequest {
  Future call(NewUser user);
}
