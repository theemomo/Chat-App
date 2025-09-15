import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/services/auth_services.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final _authServices = AuthServices();

  Future<void> register(String email, String password) async {
    emit(RegisterLoading());
    try {
      await _authServices.signUp(email, password);
      emit(RegisterSuccessfully());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
