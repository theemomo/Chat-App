part of 'register_cubit.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class RegisterLoading extends RegisterState {}

final class RegisterSuccessfully extends RegisterState {}

final class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure(this.message);
}
