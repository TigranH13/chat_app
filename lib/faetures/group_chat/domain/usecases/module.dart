import 'package:chat_application/faetures/group_chat/domain/usecases/create_group_impl.dart';
import 'package:chat_application/faetures/group_chat/domain/usecases/leave_group_impl.dart';
import 'package:chat_application/faetures/group_chat/domain/usecases/remove_members_impl.dart';

final createGroup = CreateGroupImpl();

final leaveGroup = LeaveGroupImpl();
final removeMembers = RemoveMembersImpl();
