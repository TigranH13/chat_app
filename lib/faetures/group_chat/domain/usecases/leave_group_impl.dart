import 'package:chat_application/faetures/group_chat/data/repository/gorup_chat_repositroy_impl.dart';
import 'package:chat_application/faetures/group_chat/domain/usecases/leave_group.dart';

class LeaveGroupImpl implements LeaveGroup {
  @override
  Future call(List membersList, String id) async {
    await GroupChatRepositoryImpl().leaveGroup(membersList, id);
  }
}
