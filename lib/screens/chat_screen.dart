import 'package:chat_app/constant.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/screens/cubit/chat_screen_cubit.dart';
import 'package:chat_app/screens/cubit/chat_screen_state.dart';
import 'package:chat_app/widget/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'Chat Screen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<MessagesModel> messagesList = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, height: 50),
            Text(
              'GoChat',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Pacifico',
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatscreenCubit, ChatscreenState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messagesList;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBubble(messagesModel: messagesList[index])
                        : ChatBubbleForFriend(
                            messagesModel: messagesList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                final text = data.trim(); // <-- عرّف text
                if (text.isEmpty) return;
                BlocProvider.of<ChatscreenCubit>(context).sendMessage(
                  message: text,
                  email: FirebaseAuth.instance.currentUser!.email!,
                );
                controller.clear();
              },

              decoration: InputDecoration(
                hintText: 'Send Message',

                suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
