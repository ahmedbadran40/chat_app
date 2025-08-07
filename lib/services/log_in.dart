import 'package:firebase_auth/firebase_auth.dart';

class LogInUser {
  Future<UserCredential> logInUser({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
