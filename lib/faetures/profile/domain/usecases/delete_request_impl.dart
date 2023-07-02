import 'package:chat_application/faetures/auth/domain/model/user_model.dart';
import 'package:chat_application/faetures/profile/data/repositroy/profile_repository_impl.dart';
import 'package:chat_application/faetures/profile/domain/usecases/delete_request.dart';

class DeleteRequestImpl implements DeleteRequest {
  @override
  Future call(NewUser user) async {
    ProfileRepositroyImpl().deleteRequest(user);
  }
}
