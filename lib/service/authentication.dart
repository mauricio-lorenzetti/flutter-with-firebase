import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_with_flutter/service/database.dart';

class AuthenticationService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  AuthenticationService();

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<auth.User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on auth.FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      auth.UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      auth.User user = credential.user;
      await DatabaseService(uid: user.uid).updateUserData("todo",
          "111.111.111-11", user.email, user.displayName, user.phoneNumber);
      return "Signed up";
    } on auth.FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
