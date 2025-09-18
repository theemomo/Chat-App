import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:chat_app/features/chat/services/chat_services.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final ChatServices _chatServices = ChatServices();

  // Send message
  Future<void> sendMessage(String receiverID, String message) async {
    try {
      await _chatServices.sendMessage(receiverID, message);
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  // Get messages stream
  Stream<List<MessageModel>> getMessages(String userID, String otherUserID) {
    return _chatServices.getMessages(userID, otherUserID).map((snapshot) {
      return snapshot.docs.map((doc) {
        return MessageModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Stream<List<MessageModel>> getMessages(String userID, String otherUserID) {
  //   return _chatServices.getMessages(userID, otherUserID).map((snapshot) {
  //     final messages = snapshot.docs.map((doc) {
  //       return MessageModel.fromMap(doc.data() as Map<String, dynamic>);
  //     }).toList();

  //     // sort after mapping
  //     messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

  //     return messages;
  //   });
  // }
}
