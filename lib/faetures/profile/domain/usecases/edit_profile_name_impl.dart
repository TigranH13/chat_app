import 'package:chat_application/faetures/chat/data/repository/chat_repository_impl.dart';
import 'package:chat_application/faetures/profile/data/repositroy/profile_repository_impl.dart';
import 'package:chat_application/faetures/profile/domain/usecases/edit_profile_name.dart';

class EditProfileNameImpl implements EditProfileName {
  @override
  Future call(String name) async {
    ProfileRepositroyImpl().editProfileName(name);
  }
}
