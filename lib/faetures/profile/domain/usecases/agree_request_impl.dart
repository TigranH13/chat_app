import 'package:chat_application/faetures/auth/domain/model/user_model.dart';
import 'package:chat_application/faetures/profile/data/repositroy/profile_repository_impl.dart';
import 'package:chat_application/faetures/profile/domain/usecases/agree_request.dart';

class AgreeRequestImpl implements AgreeRequest {
  @override
  Future call(NewUser user) async {
    ProfileRepositroyImpl().agreeRequest(user);
  }
}
