import 'dart:ffi';
import 'dart:io';

import 'package:chat_application/faetures/auth/data/sources/get_image_impl.dart';
import 'package:chat_application/faetures/auth/domain/model/user_model.dart';
import 'package:chat_application/faetures/group_chat/presentation/providers/add_remove_member_list.dart';
import 'package:chat_application/faetures/profile/presentation/providers/get_user.dart';
import 'package:chat_application/faetures/profile/presentation/providers/search_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUserProvider =
    StateNotifierProvider<GetUserById, NewUser?>((ref) => GetUserById());

final imgProvider =
    StateNotifierProvider<GetImageImpl, File?>((ref) => GetImageImpl());

final searchPRovider =
    StateNotifierProvider<SearchUser, List?>((ref) => SearchUser());
