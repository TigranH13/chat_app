import 'package:chat_application/faetures/group_chat/data/repository/gorup_chat_repositroy_impl.dart';
import 'package:chat_application/faetures/group_chat/domain/usecases/remove_members.dart';

class RemoveMembersImpl implements RemoveMembers {
  @override
  Future call(int index, List membersList, String id) async {
    await GroupChatRepositoryImpl().removeMembers(index, membersList, id);
  }
}
