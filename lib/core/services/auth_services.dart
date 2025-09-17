import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/utils/api_paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // instance of auth & firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign in (login)
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      // save user info in firestore
      _firestore
          .collection(ApiPaths.usersCollection)
          .doc(user.user!.uid)
          .set(UserModel(id: user.user!.uid, email: user.user!.email).toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // sign up (register)
  Future<UserCredential> signUp(String email, String password) async {
    try {
      // create user
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // save user info in firestore
      _firestore
          .collection(ApiPaths.usersCollection)
          .doc(user.user!.uid)
          .set(UserModel(id: user.user!.uid, email: user.user!.email).toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out (logout)
  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
