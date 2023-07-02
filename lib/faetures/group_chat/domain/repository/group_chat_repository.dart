import 'package:chat_application/faetures/group_chat/presentation/screens/create_group_screen.dart';

abstract class GroupChatRepository {
  Future createGroup(List membersList, String groupName);
  Future leaveGroup(List membersList, String id);
  Future removeMembers(int index, List membersList, String id);
}
