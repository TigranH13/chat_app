import 'package:chat_application/faetures/auth/data/repository/auth_impl.dart';
import 'package:chat_application/faetures/auth/domain/usecases/register_user_with_google.dart';

class RegisterUserWithGoogleImpl implements RegisterUserWithGoogle {
  @override
  Future call() async {
    await AuthRepositoryImpl().registerUserWithGoogle();
  }
}
