import 'package:chat_application/faetures/auth/domain/model/user_model.dart';
import 'package:chat_application/faetures/profile/data/repositroy/profile_repository_impl.dart';
import 'package:chat_application/faetures/profile/domain/usecases/remove_friend.dart';

class RemoveFriendImpl implements RemoveFriend {
  @override
  Future call(NewUser user) async {
    ProfileRepositroyImpl().removeFriend(user);
  }
}
