part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatFailure extends ChatState {
  final String message;
  ChatFailure(this.message);
}
