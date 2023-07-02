import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/presentation/providers/search_user.dart';
import 'add_remove_member_list.dart';

final searchProvider =
    StateNotifierProvider<SearchUser, List?>((ref) => SearchUser());

final membersListProvider =
    StateNotifierProvider<AddRemoveMemberList, List<Map<String, dynamic>>>(
        (ref) => AddRemoveMemberList());
