import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final authServices = AuthServices();
  void checkAuthStatus() {
    final user = authServices.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }
}
