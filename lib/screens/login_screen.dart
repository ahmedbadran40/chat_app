import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snak_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/cubit/chat_screen_cubit.dart';
import 'package:chat_app/screens/login_cubit/login_cubit.dart';
import 'package:chat_app/screens/login_cubit/login_state.dart';
import 'package:chat_app/screens/sign_up_screen.dart';

import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatscreenCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatScreen.id);
        } else if (state is LoginFailure) {
          showSnakBar(context, state.error, Colors.red);
        }
      },
      child: ModalProgressHUD(
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
                        BlocProvider.of<LoginCubit>(
                          context,
                        ).loginUser(email: email!, password: password!);
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
      ),
    );
  }
}
