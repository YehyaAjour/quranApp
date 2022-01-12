
import 'package:quranapp/model/login_response.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class ChangePasswordVisibilityState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccessState(this.loginResponse);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class LogoutLoadingState extends LoginState {}

class LogoutSuccessState extends LoginState {}

class LogoutErrorState extends LoginState {}
