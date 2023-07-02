import 'package:chat_application/faetures/auth/domain/usecases/log_out_impl.dart';
import 'package:chat_application/faetures/auth/domain/usecases/login_with_email_and_password.dart';
import 'package:chat_application/faetures/auth/domain/usecases/login_with_email_and_password_impl.dart';
import 'package:chat_application/faetures/auth/domain/usecases/register_user_with_email_and_password.dart';
import 'package:chat_application/faetures/auth/domain/usecases/register_user_with_email_and_password_impl.dart';
import 'package:chat_application/faetures/auth/domain/usecases/register_user_with_google_impl.dart';

final logut = LogOutIMpl();
final registerUserWithEmailAndPassword = RegisterUserWithEmailandPasswordImpl();
final loginWithEmailandPassword = LoginWithEmailandPasswordImpl();
final loginWithGoogle = RegisterUserWithGoogleImpl();
