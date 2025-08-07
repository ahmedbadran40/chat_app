import 'package:firebase_auth/firebase_auth.dart';

class CreateUserService {
  Future<UserCredential> createUser({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
