import 'package:chat_app/core/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _authServices = AuthServices();

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    // try {
      await _authServices.signIn(email, password);
      emit(LoginSuccessfully());
    // } catch (e) {
    //   emit(LoginFailure(e.toString()));
    // }
  }
}
