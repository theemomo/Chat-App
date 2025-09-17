import 'package:chat_app/core/utils/api_paths.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  // get instance oof firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  // send message
  Future<void> sendMessage(String receiverID, String message) async {
    // get current user info
    final currentUserEmail = currentUser.email!;
    final currentUserID = currentUser.uid;
    final Timestamp timestamp = Timestamp.now();

    // create new message
    final MessageModel newMessage = MessageModel(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two users
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatroomID = ids.join("_");

    // add niw message to database
    await _firestore
        .collection(ApiPaths.chatRoomsCollection)
        .doc(chatroomID)
        .collection(ApiPaths.messagesCollection)
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    // construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
        .collection(ApiPaths.chatRoomsCollection)
        .doc(chatRoomID)
        .collection(ApiPaths.messagesCollection)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
