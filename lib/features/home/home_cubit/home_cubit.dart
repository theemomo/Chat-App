import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/services/firestore_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final _authServices = AuthServices();
  final _firestoreServices = FirestoreServices();

  Future<void> logout() async {
    await _authServices.signOut();
  }

  void getUsers() {
    emit(HomeLoading());
    try {
      final stream = _firestoreServices.getUsersStream();
      emit(HomeLoaded(stream));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
