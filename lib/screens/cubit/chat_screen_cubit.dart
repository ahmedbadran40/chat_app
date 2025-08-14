import 'package:chat_app/constant.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/screens/cubit/chat_screen_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatscreenCubit extends Cubit<ChatscreenState> {
  ChatscreenCubit() : super(ChatscreenInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollections,
  );
  List<MessagesModel> messagesList = [];
  void sendMessage({required String message, required String email}) {
    messages.add({kMessage: message, kCreatedAt: DateTime.now(), kId: email});
  }

  void getMessage() {
    messages.orderBy(kCreatedAt, descending: false).snapshots().listen((event) {
      messagesList.clear();

      for (var doc in event.docs) {
        messagesList.add(MessagesModel.fromJson(doc));
      }
      emit(ChatSuccess(messagesList: messagesList));
    });
  }
}
