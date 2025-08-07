import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snak_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/sign_up_screen.dart';
import 'package:chat_app/services/log_in.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 75),
                Center(child: Image.asset('assets/images/scholar.png')),
                Center(
                  child: Text(
                    'Go Chat',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 75),
                CustomText(text: 'LOGIN'),
                CustomFormTextField(
                  onChanged: (data) => email = data,
                  hintText: 'Email',
                ),
                const SizedBox(height: 10),
                CustomFormTextField(
                  obscureText: true,
                  onChanged: (data) => password = data,
                  hintText: 'Password',
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() => isLoading = true);
                      try {
                        await LogInUser().logInUser(
                          email: email!,
                          password: password!,
                        );
                        Navigator.pushNamed(
                          context,
                          ChatScreen.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'invalid-credential' ||
                            ex.code == 'invalid-login-credentials' ||
                            ex.code == 'wrong-password') {
                          showSnakBar(
                            context,
                            'Wrong email or password.',
                            Colors.red,
                          );
                        } else if (ex.code == 'user-disabled') {
                          showSnakBar(
                            context,
                            'This user has been disabled.',
                            Colors.red,
                          );
                        } else if (ex.code == 'invalid-email') {
                          showSnakBar(
                            context,
                            'The email address is invalid.',
                            Colors.red,
                          );
                        } else {
                          showSnakBar(
                            context,
                            'Login failed: ${ex.message}',
                            Colors.red,
                          );
                        }
                      } catch (e) {
                        showSnakBar(
                          context,
                          'An error occurred. Please try again.',
                          Colors.red,
                        );
                      }
                      setState(() => isLoading = false);
                    }
                  },
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, SignUpScreen.id),
                      child: const Text(
                        ' SIGN UP ',
                        style: TextStyle(color: Color(0xffc7ede6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
