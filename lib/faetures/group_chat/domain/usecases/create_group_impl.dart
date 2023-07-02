import 'package:chat_application/faetures/group_chat/data/repository/gorup_chat_repositroy_impl.dart';

import 'create_group.dart';

class CreateGroupImpl implements CreateGroup {
  @override
  Future call(List membersList, String groupName) async {
    await GroupChatRepositoryImpl().createGroup(membersList, groupName);
  }
}
