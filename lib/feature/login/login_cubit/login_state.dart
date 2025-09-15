part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccessfully extends LoginState {}

final class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
