import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snak_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/sign_up_cubit/sign_cubit_cubit.dart';
import 'package:chat_app/screens/sign_up_cubit/sign_cubit_state.dart';

import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static String id = 'SIGN UP Screen';
  String? email;

  String? password;

  bool isLodaing = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubitCubit, SignCubitState>(
      listener: (context, state) {
        if (state is SignCubitLoading) {
          isLodaing = true;
        } else if (state is SignCubitSuccess) {
          Navigator.pushNamed(context, ChatScreen.id);
        } else if (state is SignCubitFailure) {
          showSnakBar(context, state.error, Colors.red);
        }
      },
      builder: (context, state) {
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
                          BlocProvider.of<SignCubitCubit>(
                            context,
                          ).signUpUser(email: email!, password: password!);
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
      },
    );
  }
}
