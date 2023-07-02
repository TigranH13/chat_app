import 'package:chat_application/faetures/auth/domain/model/user_model.dart';
import 'package:chat_application/faetures/profile/data/repositroy/profile_repository_impl.dart';
import 'package:chat_application/faetures/profile/domain/usecases/add_request.dart';

class AddRequestImpl implements AddRequest {
  @override
  Future call(NewUser user) async {
    ProfileRepositroyImpl().addRequest(user);
  }
}
