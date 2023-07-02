import 'package:chat_application/faetures/auth/domain/model/user_model.dart';

abstract class DeleteRequest {
  Future call(NewUser user);
}
