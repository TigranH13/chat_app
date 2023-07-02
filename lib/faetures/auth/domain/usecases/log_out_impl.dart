import 'package:chat_application/faetures/auth/data/repository/auth_impl.dart';
import 'package:chat_application/faetures/auth/domain/repository/auth_repository.dart';
import 'package:chat_application/faetures/auth/domain/usecases/log_out.dart';

class LogOutIMpl implements LogOut {
  final repository = AuthRepositoryImpl();
  @override
  Future call() async {
    await repository.logOut();
  }
}
