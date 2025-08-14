import 'package:chat_app/screens/sign_up_cubit/sign_cubit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

class SignCubitCubit extends Cubit<SignCubitState> {
  SignCubitCubit() : super(SignCubitInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpUser({
    required String email,
    required String password,
  }) async {
    emit(SignCubitLoading());

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      emit(SignCubitSuccess(userCredential.user!.uid));
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'email-already-in-use') {
        errorMessage = "Email is already in use";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format";
      } else if (e.code == 'weak-password') {
        errorMessage = "Password should be at least 6 characters";
      } else {
        errorMessage = e.message ?? "An unexpected error occurred";
      }

      emit(SignCubitFailure(errorMessage));
    } catch (e) {
      emit(SignCubitFailure(e.toString()));
    }
  }
}
