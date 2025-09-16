import 'package:chat_app/core/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final _authServices = AuthServices();

  Future<void> logout() async {
    await _authServices.signOut();
  }
}
