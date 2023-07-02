import 'package:chat_application/faetures/profile/data/repositroy/profile_repository_impl.dart';
import 'package:chat_application/faetures/profile/domain/usecases/agree_request_impl.dart';
import 'package:chat_application/faetures/profile/domain/usecases/edit_profile_image_impl.dart';
import 'package:chat_application/faetures/profile/domain/usecases/edit_profile_name_impl.dart';
import 'package:chat_application/faetures/profile/domain/usecases/remove_friend_impl.dart';

import 'delete_request_impl.dart';

final editProfileImage = EditProfileImageUseCaseImpl(ProfileRepositroyImpl());
final editProfileName = EditProfileNameImpl();
final removeFriend = RemoveFriendImpl();
final deleteRequest = DeleteRequestImpl();
final agreeRequest = AgreeRequestImpl();
final addRequest = AgreeRequestImpl();
