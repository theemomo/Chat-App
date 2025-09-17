import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/utils/api_paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  // get instance oof firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email;

  // get user stream
  Stream<List<UserModel>> getUsersStream() {
    // _firestore.collection(ApiPaths.users) => gets the users collection from firestore
    // snapshots() listens to real time updates form firestore. 
    // Anytime a document in the users collection is added, updated, or deleted, Firestore sends a new QuerySnapshot.
    return _firestore.collection(ApiPaths.users).snapshots().map((snapshot) {
      // go through each snapshot (users)
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return UserModel.fromMap(user);
      }).where((user) => user.email != currentUserEmail).toList();
    });
  }
}
