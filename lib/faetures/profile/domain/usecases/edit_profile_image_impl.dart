import 'dart:io';

import 'package:chat_application/faetures/profile/data/repositroy/profile_repository_impl.dart';

import 'edit_profile_image.dart';

class EditProfileImageUseCaseImpl extends EditProfileImageUseCase {
  final ProfileRepositroyImpl profileRepositroyImpl;

  EditProfileImageUseCaseImpl(this.profileRepositroyImpl);
  @override
  Future call(File image) async {
    await profileRepositroyImpl.editProfileImage(image);
  }
}
