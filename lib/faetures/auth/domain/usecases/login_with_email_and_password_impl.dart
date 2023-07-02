import 'package:chat_application/faetures/auth/data/repository/auth_impl.dart';
import 'package:chat_application/faetures/auth/domain/usecases/login_with_email_and_password.dart';

class LoginWithEmailandPasswordImpl implements LoginWithEmailandPassword {
  @override
  Future call(String email, String password) async {
    await AuthRepositoryImpl().loginWithEmailandPassword(email, password);
  }
}
