import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snak_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/services/create_user.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'SIGN UP Screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;

  String? password;

  bool isLodaing = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLodaing,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 75),
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
                SizedBox(height: 75),
                CustomText(text: 'SIGN UP'),

                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(height: 10),
                CustomFormTextField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() => isLodaing = true);
                      try {
                        await CreateUserService().createUser(
                          email: email!,
                          password: password!,
                        );
                        Navigator.pushNamed(
                          context,
                          ChatScreen.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnakBar(
                            context,
                            'The password is too weak.',
                            Colors.red,
                          );
                        } else if (ex.code == 'email-already-in-use') {
                          showSnakBar(
                            context,
                            'Email already in use.',
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
                            'Sign up failed: ${ex.message}',
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
                      setState(() => isLodaing = false);
                    }
                  },
                  text: 'Sin Up',
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'allready have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '  LOGIN ',
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
