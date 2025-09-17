part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final Stream stream;
  HomeLoaded(this.stream);
}

final class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);
}
